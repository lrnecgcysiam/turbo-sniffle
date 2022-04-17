# Convert to twos complement from 8bit binary
#  The expression $((2#$binary)) does conversion from binary to decimal.
# The commands [ "$x" -gt 127 ] && ((x=x-256)) perform two's complement on an 8-bit value.
binary=$1
fromDecimal=$((2#$binary))
[ "$fromDecimal" -gt 127 ] && ((x=x-256)); echo "$fromDecimal"
