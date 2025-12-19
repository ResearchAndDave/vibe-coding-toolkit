#!/bin/bash
# verify-ai-claims.sh - Never trust "all tests pass" without verification
# Part of the Inner Developer Loop Toolkit

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Results tracking
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0

log_check() {
    echo -e "${BLUE}[CHECK]${NC} $1"
    ((TOTAL_CHECKS++))
}

log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((PASSED_CHECKS++))
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((FAILED_CHECKS++))
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARNINGS++))
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Detect project type
detect_project_type() {
    if [ -f "package.json" ]; then
        echo "node"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        echo "python"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ] || [ -f "pom.xml" ]; then
        echo "java"
    else
        echo "unknown"
    fi
}

# Check: Tests compile/can be found
check_tests_exist() {
    log_check "Tests exist and can be found"
    
    local project_type=$(detect_project_type)
    local found=false
    
    case $project_type in
        node)
            if [ -d "test" ] || [ -d "tests" ] || [ -d "__tests__" ] || \
               find . -name "*.test.js" -o -name "*.spec.js" -o -name "*.test.ts" -o -name "*.spec.ts" 2>/dev/null | grep -q .; then
                found=true
            fi
            ;;
        python)
            if [ -d "tests" ] || [ -d "test" ] || \
               find . -name "test_*.py" -o -name "*_test.py" 2>/dev/null | grep -q .; then
                found=true
            fi
            ;;
        rust)
            if grep -r "#\[test\]" --include="*.rs" . 2>/dev/null | grep -q .; then
                found=true
            fi
            ;;
        go)
            if find . -name "*_test.go" 2>/dev/null | grep -q .; then
                found=true
            fi
            ;;
        java)
            if [ -d "src/test" ] || find . -name "*Test.java" -o -name "*Tests.java" 2>/dev/null | grep -q .; then
                found=true
            fi
            ;;
    esac
    
    if [ "$found" = true ]; then
        log_pass "Test files found"
    else
        log_fail "No test files found"
    fi
}

# Check: Tests actually run
check_tests_run() {
    log_check "Tests can execute (dry run)"
    
    local project_type=$(detect_project_type)
    local result=0
    
    case $project_type in
        node)
            if [ -f "package.json" ]; then
                if grep -q '"test"' package.json; then
                    log_pass "Test script defined in package.json"
                else
                    log_warn "No test script in package.json"
                fi
            fi
            ;;
        python)
            if command -v pytest &> /dev/null; then
                log_pass "pytest available"
            elif command -v python &> /dev/null; then
                log_pass "python available for unittest"
            else
                log_fail "No Python test runner found"
            fi
            ;;
        rust)
            if command -v cargo &> /dev/null; then
                log_pass "cargo available for tests"
            else
                log_fail "cargo not found"
            fi
            ;;
        go)
            if command -v go &> /dev/null; then
                log_pass "go available for tests"
            else
                log_fail "go not found"
            fi
            ;;
        java)
            if [ -f "gradlew" ] || [ -f "mvnw" ] || command -v gradle &> /dev/null || command -v mvn &> /dev/null; then
                log_pass "Java build tool available"
            else
                log_fail "No Java build tool found"
            fi
            ;;
        *)
            log_warn "Unknown project type - manual verification needed"
            ;;
    esac
}

# Check: Run tests and capture results
check_tests_pass() {
    log_check "Tests actually pass"
    
    local project_type=$(detect_project_type)
    local exit_code=0
    
    echo ""
    log_info "Running tests..."
    echo "────────────────────────────────────────"
    
    case $project_type in
        node)
            npm test 2>&1 || exit_code=$?
            ;;
        python)
            if command -v pytest &> /dev/null; then
                pytest -v 2>&1 || exit_code=$?
            else
                python -m unittest discover -v 2>&1 || exit_code=$?
            fi
            ;;
        rust)
            cargo test 2>&1 || exit_code=$?
            ;;
        go)
            go test -v ./... 2>&1 || exit_code=$?
            ;;
        java)
            if [ -f "gradlew" ]; then
                ./gradlew test 2>&1 || exit_code=$?
            elif [ -f "mvnw" ]; then
                ./mvnw test 2>&1 || exit_code=$?
            elif command -v gradle &> /dev/null; then
                gradle test 2>&1 || exit_code=$?
            else
                mvn test 2>&1 || exit_code=$?
            fi
            ;;
        *)
            log_warn "Cannot auto-run tests for unknown project type"
            return
            ;;
    esac
    
    echo "────────────────────────────────────────"
    echo ""
    
    if [ $exit_code -eq 0 ]; then
        log_pass "All tests passed"
    else
        log_fail "Tests failed with exit code: $exit_code"
    fi
}

# Check: No skipped/disabled tests hiding problems
check_skipped_tests() {
    log_check "Checking for skipped/disabled tests"
    
    local skipped_patterns=(
        "@Disabled"
        "@Ignore"
        "@skip"
        "skip("
        "xtest"
        "xit("
        "xdescribe"
        "test.skip"
        "describe.skip"
        "pytest.mark.skip"
        "#[ignore]"
    )
    
    local found_skips=""
    
    for pattern in "${skipped_patterns[@]}"; do
        local results=$(grep -r "$pattern" --include="*.js" --include="*.ts" --include="*.py" --include="*.java" --include="*.rs" --include="*.go" . 2>/dev/null || true)
        if [ -n "$results" ]; then
            found_skips="$found_skips\n$results"
        fi
    done
    
    if [ -n "$found_skips" ]; then
        log_warn "Found skipped/disabled tests:"
        echo -e "$found_skips" | head -10
        echo ""
    else
        log_pass "No skipped tests found"
    fi
}

# Check: Code compiles/builds
check_build() {
    log_check "Code compiles/builds"
    
    local project_type=$(detect_project_type)
    local exit_code=0
    
    case $project_type in
        node)
            if grep -q '"build"' package.json 2>/dev/null; then
                npm run build 2>&1 || exit_code=$?
            elif grep -q '"tsc"' package.json 2>/dev/null || [ -f "tsconfig.json" ]; then
                npx tsc --noEmit 2>&1 || exit_code=$?
            else
                log_info "No build step defined"
                return
            fi
            ;;
        rust)
            cargo build 2>&1 || exit_code=$?
            ;;
        go)
            go build ./... 2>&1 || exit_code=$?
            ;;
        java)
            if [ -f "gradlew" ]; then
                ./gradlew compileJava compileTestJava 2>&1 || exit_code=$?
            elif [ -f "mvnw" ]; then
                ./mvnw compile test-compile 2>&1 || exit_code=$?
            fi
            ;;
        python)
            # Python doesn't compile, but we can check syntax
            if command -v python &> /dev/null; then
                python -m py_compile $(find . -name "*.py" -not -path "./venv/*" -not -path "./.venv/*" 2>/dev/null) 2>&1 || exit_code=$?
            fi
            ;;
    esac
    
    if [ $exit_code -eq 0 ]; then
        log_pass "Build successful"
    else
        log_fail "Build failed"
    fi
}

# Check: Linting passes
check_lint() {
    log_check "Linting passes"
    
    local project_type=$(detect_project_type)
    local exit_code=0
    
    case $project_type in
        node)
            if grep -q '"lint"' package.json 2>/dev/null; then
                npm run lint 2>&1 || exit_code=$?
            elif [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ] || [ -f ".eslintrc" ]; then
                npx eslint . 2>&1 || exit_code=$?
            else
                log_info "No linter configured"
                return
            fi
            ;;
        python)
            if command -v ruff &> /dev/null; then
                ruff check . 2>&1 || exit_code=$?
            elif command -v flake8 &> /dev/null; then
                flake8 . 2>&1 || exit_code=$?
            else
                log_info "No Python linter found"
                return
            fi
            ;;
        rust)
            cargo clippy 2>&1 || exit_code=$?
            ;;
        go)
            if command -v golint &> /dev/null; then
                golint ./... 2>&1 || exit_code=$?
            else
                go vet ./... 2>&1 || exit_code=$?
            fi
            ;;
    esac
    
    if [ $exit_code -eq 0 ]; then
        log_pass "Linting passed"
    else
        log_warn "Linting has issues"
    fi
}

# Check: No new warnings
check_warnings() {
    log_check "Checking for compiler/interpreter warnings"
    
    # This is highly project-specific
    # Just check for common warning patterns in recent output
    log_info "Review build/test output above for warnings"
    log_pass "Manual review required"
}

# Check: Type checking (if applicable)
check_types() {
    log_check "Type checking"
    
    local project_type=$(detect_project_type)
    local exit_code=0
    
    case $project_type in
        node)
            if [ -f "tsconfig.json" ]; then
                npx tsc --noEmit 2>&1 || exit_code=$?
            else
                log_info "No TypeScript config found"
                return
            fi
            ;;
        python)
            if command -v mypy &> /dev/null; then
                mypy . 2>&1 || exit_code=$?
            else
                log_info "mypy not installed"
                return
            fi
            ;;
    esac
    
    if [ $exit_code -eq 0 ]; then
        log_pass "Type checking passed"
    else
        log_warn "Type errors found"
    fi
}

# Generate summary
print_summary() {
    echo ""
    echo "════════════════════════════════════════"
    echo "         VERIFICATION SUMMARY           "
    echo "════════════════════════════════════════"
    echo ""
    echo -e "Total Checks:  $TOTAL_CHECKS"
    echo -e "${GREEN}Passed:        $PASSED_CHECKS${NC}"
    echo -e "${RED}Failed:        $FAILED_CHECKS${NC}"
    echo -e "${YELLOW}Warnings:      $WARNINGS${NC}"
    echo ""
    
    if [ $FAILED_CHECKS -eq 0 ]; then
        echo -e "${GREEN}✓ AI claims VERIFIED${NC}"
        echo ""
        exit 0
    else
        echo -e "${RED}✗ AI claims NOT VERIFIED - $FAILED_CHECKS checks failed${NC}"
        echo ""
        exit 1
    fi
}

# Main
main() {
    echo ""
    echo "════════════════════════════════════════"
    echo "    AI Claim Verification Script        "
    echo "    'Trust, but verify'                 "
    echo "════════════════════════════════════════"
    echo ""
    
    local project_type=$(detect_project_type)
    log_info "Detected project type: $project_type"
    echo ""
    
    check_tests_exist
    check_tests_run
    check_build
    check_tests_pass
    check_skipped_tests
    check_lint
    check_types
    check_warnings
    
    print_summary
}

main "$@"
