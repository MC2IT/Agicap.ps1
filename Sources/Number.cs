namespace Mc2it.Agicap;

/// <summary>
/// Provides helper methods to convert numeric values.
/// </summary>
public static class Number {

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
