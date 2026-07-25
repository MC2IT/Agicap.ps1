namespace Mc2it.Agicap;

/// <summary>
/// Provides helper methods to convert numeric values.
/// </summary>
internal static class Number {

	/// <summary>
	/// Converts the specified value to a decimal floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A decimal floating-point number that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static decimal? AsDecimal(object? value) => value switch {
		decimal number => number,
		float f32 => f32 >= (float) decimal.MinValue && f32 <= (float) decimal.MaxValue ? (decimal) f32 : null,
		double f64 => f64 >= (double) decimal.MinValue && f64 <= (double) decimal.MaxValue ? (decimal) f64 : null,
		sbyte int8 => int8,
		byte uint8 => uint8,
		short int16 => int16,
		ushort uint16 => uint16,
		int int32 => int32,
		uint uint32 => uint32,
		long int64 => int64,
		ulong uint64 => uint64,
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a double-precision floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A double-precision floating-point number that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static double? AsDouble(object? value) => value switch {
		decimal number => decimal.ToDouble(number),
		float f32 => f32,
		double f64 => f64,
		sbyte int8 => int8,
		byte uint8 => uint8,
		short int16 => int16,
		ushort uint16 => uint16,
		int int32 => int32,
		uint uint32 => uint32,
		long int64 => int64,
		ulong uint64 => uint64,
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a 32-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A 32-bit signed integer that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static int? AsInt32(object? value) => value switch {
		sbyte int8 => int8,
		byte uint8 => uint8,
		short int16 => int16,
		ushort uint16 => uint16,
		int int32 => int32,
		uint uint32 => uint32 <= int.MaxValue ? (int) uint32 : null,
		long int64 => int64 >= int.MinValue && int64 <= int.MaxValue ? (int) int64 : null,
		ulong uint64 => uint64 <= int.MaxValue ? (int) uint64 : null,
		_ => null
	};
}
