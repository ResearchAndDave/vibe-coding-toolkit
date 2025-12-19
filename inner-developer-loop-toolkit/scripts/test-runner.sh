#!/bin/bash
#
# test-runner.sh - Test Automation for AI-Assisted Development
# Part of the Inner Developer Loop Toolkit
#
# Purpose: Run tests continuously, detect failures instantly,
#          and prevent AI from silently breaking your code.
#
# Usage:
#   test-runner.sh [command] [options]
#
# Commands:
#   watch       - Run tests continuously on file changes
#   once        - Run tests once and report
#   verify      - Verify AI's "tests pass" claim
#   coverage    - Run with coverage report
#   quick       - Run only fast unit tests
#   failed      - Re-run only previously failed tests
#
# From Chapter 14: "The case for TDD has never been stronger...
# With AI, we're generating code at unprecedented speeds—which 
# means bugs can multiply just as rapidly if we're not careful."

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TEST_RESULTS_FILE=".test-results.json"
LAST_PASS_FILE=".last-test-pass"

#------------------------------------------------------------------------------
# UTILITY FUNCTIONS
#------------------------------------------------------------------------------

log_info() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

#------------------------------------------------------------------------------
# PROJECT DETECTION
#------------------------------------------------------------------------------

detect_project_type() {
    if [ -f "package.json" ]; then
        echo "node"
    elif [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        echo "python"
    elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
        echo "gradle"
    elif [ -f "pom.xml" ]; then
        echo "maven"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    elif [ -f "Gemfile" ]; then
        echo "ruby"
    else
        echo "unknown"
    fi
}

#------------------------------------------------------------------------------
# TEST RUNNERS BY PROJECT TYPE
#------------------------------------------------------------------------------

run_node_tests() {
    local mode=$1
    
    if [ -f "package.json" ]; then
        # Check which test runner is configured
        if grep -q '"jest"' package.json 2>/dev/null; then
            case $mode in
                watch)
                    npm test -- --watch
                    ;;
                coverage)
                    npm test -- --coverage
                    ;;
                quick)
                    npm test -- --onlyChanged
                    ;;
                failed)
                    npm test -- --onlyFailures
                    ;;
                *)
                    npm test
                    ;;
            esac
        elif grep -q '"vitest"' package.json 2>/dev/null; then
            case $mode in
                watch)
                    npx vitest --watch
                    ;;
                coverage)
                    npx vitest --coverage
                    ;;
                *)
                    npx vitest run
                    ;;
            esac
        elif grep -q '"mocha"' package.json 2>/dev/null; then
            case $mode in
                watch)
                    npx mocha --watch
                    ;;
                *)
                    npx mocha
                    ;;
            esac
        else
            npm test
        fi
    fi
}

run_python_tests() {
    local mode=$1
    
    if command -v pytest &> /dev/null; then
        case $mode in
            watch)
                if command -v ptw &> /dev/null; then
                    ptw
                else
                    log_warning "Install pytest-watch for watch mode: pip install pytest-watch"
                    pytest
                fi
                ;;
            coverage)
                pytest --cov --cov-report=html
                ;;
            quick)
                pytest -x --ff
                ;;
            failed)
                pytest --lf
                ;;
            *)
                pytest -v
                ;;
        esac
    elif [ -f "manage.py" ]; then
        python manage.py test
    else
        python -m unittest discover
    fi
}

run_gradle_tests() {
    local mode=$1
    
    case $mode in
        watch)
            ./gradlew test --continuous
            ;;
        quick)
            ./gradlew test --fail-fast
            ;;
        *)
            ./gradlew test
            ;;
    esac
}

run_maven_tests() {
    local mode=$1
    
    case $mode in
        quick)
            mvn test -Dsurefire.failIfNoSpecifiedTests=false -DfailIfNoTests=false
            ;;
        *)
            mvn test
            ;;
    esac
}

run_go_tests() {
    local mode=$1
    
    case $mode in
        watch)
            if command -v gotestsum &> /dev/null; then
                gotestsum --watch
            else
                log_warning "Install gotestsum for watch mode: go install gotest.tools/gotestsum@latest"
                go test ./...
            fi
            ;;
        coverage)
            go test -cover ./...
            ;;
        quick)
            go test -short ./...
            ;;
        *)
            go test -v ./...
            ;;
    esac
}

run_rust_tests() {
    local mode=$1
    
    case $mode in
        watch)
            if command -v cargo-watch &> /dev/null; then
                cargo watch -x test
            else
                log_warning "Install cargo-watch for watch mode: cargo install cargo-watch"
                cargo test
            fi
            ;;
        *)
            cargo test
            ;;
    esac
}

run_ruby_tests() {
    local mode=$1
    
    if [ -f "Rakefile" ]; then
        case $mode in
            watch)
                if command -v guard &> /dev/null; then
                    guard
                else
                    bundle exec rake test
                fi
                ;;
            *)
                bundle exec rake test
                ;;
        esac
    else
        bundle exec rspec
    fi
}

#------------------------------------------------------------------------------
# MAIN TEST RUNNER
#------------------------------------------------------------------------------

run_tests() {
    local mode=${1:-once}
    local project_type=$(detect_project_type)
    
    log_info "Detected project type: $project_type"
    log_info "Running tests in mode: $mode"
    echo ""
    
    local start_time=$(date +%s)
    local exit_code=0
    
    case $project_type in
        node)
            run_node_tests $mode || exit_code=$?
            ;;
        python)
            run_python_tests $mode || exit_code=$?
            ;;
        gradle)
            run_gradle_tests $mode || exit_code=$?
            ;;
        maven)
            run_maven_tests $mode || exit_code=$?
            ;;
        go)
            run_go_tests $mode || exit_code=$?
            ;;
        rust)
            run_rust_tests $mode || exit_code=$?
            ;;
        ruby)
            run_ruby_tests $mode || exit_code=$?
            ;;
        *)
            log_error "Unknown project type. Please run tests manually."
            exit 1
            ;;
    esac
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    echo ""
    if [ $exit_code -eq 0 ]; then
        log_success "All tests passed in ${duration}s"
        date > "$LAST_PASS_FILE"
    else
        log_error "Tests failed after ${duration}s"
        
        # Check if this might be AI-related
        if [ -f "$LAST_PASS_FILE" ]; then
            local last_pass=$(cat "$LAST_PASS_FILE")
            log_warning "Last successful test run: $last_pass"
            log_warning "Consider rolling back to last good checkpoint"
        fi
    fi
    
    return $exit_code
}

#------------------------------------------------------------------------------
# VERIFY AI CLAIMS
#------------------------------------------------------------------------------

verify_ai_claims() {
    log_info "Verifying AI's claim that tests pass..."
    echo ""
    
    local project_type=$(detect_project_type)
    
    # Step 1: Check tests exist
    log_info "Step 1: Checking tests exist..."
    local test_count=0
    
    case $project_type in
        node)
            test_count=$(find . -name "*.test.js" -o -name "*.spec.js" -o -name "*.test.ts" -o -name "*.spec.ts" 2>/dev/null | wc -l)
            ;;
        python)
            test_count=$(find . -name "test_*.py" -o -name "*_test.py" 2>/dev/null | wc -l)
            ;;
        gradle|maven)
            test_count=$(find . -path "*/test/*" -name "*Test.java" -o -name "*Test.kt" 2>/dev/null | wc -l)
            ;;
        go)
            test_count=$(find . -name "*_test.go" 2>/dev/null | wc -l)
            ;;
        rust)
            test_count=$(grep -r "#\[test\]" --include="*.rs" . 2>/dev/null | wc -l)
            ;;
    esac
    
    if [ "$test_count" -eq 0 ]; then
        log_error "No tests found! AI may have deleted tests."
        return 1
    fi
    log_success "Found $test_count test files/functions"
    
    # Step 2: Run tests and capture output
    log_info "Step 2: Running tests..."
    echo ""
    
    if run_tests once; then
        echo ""
        log_success "✓ Tests actually pass (verified independently)"
        
        # Step 3: Check for suspicious patterns
        log_info "Step 3: Checking for suspicious patterns..."
        
        # Check for skipped tests
        case $project_type in
            node)
                skipped=$(grep -r "\.skip\|xit\|xdescribe" --include="*.test.js" --include="*.spec.js" . 2>/dev/null | wc -l)
                ;;
            python)
                skipped=$(grep -r "@pytest.mark.skip\|@unittest.skip" --include="*.py" . 2>/dev/null | wc -l)
                ;;
            gradle|maven)
                skipped=$(grep -r "@Disabled\|@Ignore" --include="*.java" --include="*.kt" . 2>/dev/null | wc -l)
                ;;
        esac
        
        if [ "$skipped" -gt 0 ]; then
            log_warning "Found $skipped skipped tests - review if AI disabled tests"
        fi
        
        log_success "✓ Verification complete"
        return 0
    else
        echo ""
        log_error "✗ Tests FAILED - AI's claim was false!"
        log_error "Do NOT trust AI's 'tests pass' claims. Always verify."
        return 1
    fi
}

#------------------------------------------------------------------------------
# WATCH FOR CHANGES (Generic fallback)
#------------------------------------------------------------------------------

watch_generic() {
    log_info "Starting generic file watcher..."
    log_info "Will run tests when source files change"
    log_info "Press Ctrl+C to stop"
    echo ""
    
    if command -v fswatch &> /dev/null; then
        fswatch -o . --exclude="node_modules|\.git|__pycache__|\.pytest_cache|build|dist" | while read; do
            echo ""
            log_info "Change detected, running tests..."
            run_tests once
        done
    elif command -v inotifywait &> /dev/null; then
        while true; do
            inotifywait -r -e modify,create,delete --exclude="node_modules|\.git|__pycache__|\.pytest_cache|build|dist" . 2>/dev/null
            echo ""
            log_info "Change detected, running tests..."
            run_tests once
        done
    else
        log_error "No file watcher found. Install fswatch or inotify-tools"
        exit 1
    fi
}

#------------------------------------------------------------------------------
# HELP
#------------------------------------------------------------------------------

show_help() {
    cat << EOF
Test Runner - Part of Inner Developer Loop Toolkit

Usage: test-runner.sh [command]

Commands:
  watch       Run tests continuously on file changes
  once        Run tests once (default)
  verify      Verify AI's "tests pass" claim independently
  coverage    Run with coverage report
  quick       Run only fast/changed tests
  failed      Re-run only previously failed tests
  help        Show this help

Examples:
  test-runner.sh watch      # Start continuous testing
  test-runner.sh verify     # After AI says "tests pass"
  test-runner.sh coverage   # Check test coverage

From Chapter 14 of "Vibe Coding":
  "Never assume 'it worked' or 'tests pass' without seeing the evidence."

Supported Project Types:
  - Node.js (Jest, Vitest, Mocha)
  - Python (pytest, unittest)
  - Java/Kotlin (Gradle, Maven)
  - Go
  - Rust
  - Ruby (RSpec, Minitest)

EOF
}

#------------------------------------------------------------------------------
# MAIN
#------------------------------------------------------------------------------

main() {
    local command=${1:-once}
    
    case $command in
        watch)
            run_tests watch
            ;;
        once)
            run_tests once
            ;;
        verify)
            verify_ai_claims
            ;;
        coverage)
            run_tests coverage
            ;;
        quick)
            run_tests quick
            ;;
        failed)
            run_tests failed
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
