#!/bin/bash

# Autograding Script for UI/UX Standards Assignment
SCORE=0

echo "🔍 Starting Assignment Check..."

# Check 1: File Integrity (20pts)
echo "--- Check 1: File Integrity ---"
FILES_COUNT=0
if [ -f "index.html" ]; then ((FILES_COUNT++)); echo "✅ index.html found"; fi
if [ -f "style.css" ]; then ((FILES_COUNT++)); echo "✅ style.css found"; fi
if [ -f "assets/icons/battery.svg" ]; then ((FILES_COUNT++)); echo "✅ battery.svg found"; fi
if [ -f "assets/icons/signal.svg" ]; then ((FILES_COUNT++)); echo "✅ signal.svg found"; fi
if [ -f "assets/icons/warning.svg" ]; then ((FILES_COUNT++)); echo "✅ warning.svg found"; fi

if [ $FILES_COUNT -eq 5 ]; then
    SCORE=$((SCORE + 20))
    echo "Result: PASS (+20)"
else
    echo "Result: FAIL (Required files missing: $FILES_COUNT/5)"
fi

# Check 2: HUD Structure (20pts)
echo -e "\n--- Check 2: HUD Structure ---"
HUD_CHECK=0
if grep -q "video-container" index.html; then ((HUD_CHECK++)); echo "✅ video-container found"; fi
if grep -q "hud-overlay" index.html; then ((HUD_CHECK++)); echo "✅ hud-overlay found"; fi
if grep -q "thumb-zone" index.html; then ((HUD_CHECK++)); echo "✅ thumb-zone found"; fi

if [ $HUD_CHECK -eq 3 ]; then
    SCORE=$((SCORE + 20))
    echo "Result: PASS (+20)"
else
    echo "Result: FAIL (HUD structure incomplete: $HUD_CHECK/3)"
fi

# Check 3: Design Standards (30pts)
echo -e "\n--- Check 3: Design Standards ---"
DESIGN_CHECK=0
if grep -q "\-\-primary" style.css; then ((DESIGN_CHECK++)); echo "✅ --primary variable found"; fi
if grep -q "\-\-glass-bg" style.css; then ((DESIGN_CHECK++)); echo "✅ --glass-bg variable found"; fi
if grep -q "pulse-red" style.css; then ((DESIGN_CHECK++)); echo "✅ Warning animation found"; fi

if [ $DESIGN_CHECK -eq 3 ]; then
    SCORE=$((SCORE + 30))
    echo "Result: PASS (+30)"
else
    echo "Result: FAIL (Design system requirements missing: $DESIGN_CHECK/3)"
fi

# Check 4: UX Research Report (30pts)
echo -e "\n--- Check 4: UX Research Report ---"
REPORT_CHECK=0
# Check if "____ %" has been replaced with a number (excluding the goal description)
# The placeholder is "____ %"
if grep -q "盲操成功率：[0-9]\{1,3\}" README.md; then
    ((REPORT_CHECK++))
    echo "✅ Blind operation rate filled"
fi
# Check if at least one answer has been provided (placeholder "*回答：*" followed by non-empty text)
if grep -q "\*回答：\* [^[:space:]]" README.md; then
    ((REPORT_CHECK++))
    echo "✅ Design questions answered"
fi

if [ $REPORT_CHECK -eq 2 ]; then
    SCORE=$((SCORE + 30))
    echo "Result: PASS (+30)"
else
    echo "Result: FAIL (UX Research Report incomplete: $REPORT_CHECK/2)"
fi

echo -e "\n=============================="
echo "Final Score: $SCORE / 100"
echo "=============================="

# Exit with 0 so the workflow can process the score via the reporter
exit 0
