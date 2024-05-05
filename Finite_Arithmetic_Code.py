import numpy as np

def get_symbol_frequencies(data):
    """
    Calculate the frequencies of symbols in the input data.

    Args:
        data (list or np.ndarray): Input data containing symbols.

    Returns:
        dict: Dictionary containing symbol frequencies.
    """
    if isinstance(data, np.ndarray):
        unique_elements, frequencies = np.unique(data, return_counts=True)
        symbols = dict(zip(unique_elements, frequencies))
    else:
        symbols = {}
        for char in data:
            symbols[char] = symbols.get(char, 0) + 1
    return symbols



def cumulative_frequency(symbol, frequency_dict):
    """
    Calculate the cumulative frequency of a symbol.

    Args:
        symbol: Symbol for which cumulative frequency is calculated.
        frequency_dict (dict): Dictionary containing symbol frequencies.

    Returns:
        int: Cumulative frequency of the symbol.
    """
    cumulative_freq = 0
    for sym, freq in frequency_dict.items():
        cumulative_freq += freq
        if sym == symbol:
            break
    return cumulative_freq




def arithmetic_encode(input_stream, precision=32):
    """
    Encode the input stream using the arithmetic coding algorithm.

    Args:
        input_stream (list): Input stream of symbols.
        precision (int): Number of precision bits used in the encoder.

    Returns:
        tuple: Encoded binary stream and symbol frequencies dictionary.
    """
    input_stream.append('O')
    stream_size = len(input_stream)
    symbol_freq_dict = get_symbol_frequencies(input_stream)

    full_range = 2**precision
    half_range = full_range // 2
    quarter_range = full_range // 4

    L= 0
    H= full_range
    steps = 0

    encoded_bits = []

    for symbol in input_stream:
        symbol_freq = symbol_freq_dict[symbol]
        S_high= cumulative_frequency(symbol, symbol_freq_dict)
        S_low= S_high- symbol_freq

        current_range = H- L
        H= L+ current_range * S_high// stream_size
        L= L+ current_range * S_low// stream_size

        while True:
            if H< half_range:
                encoded_bits.extend([0])
                encoded_bits.extend([1] * steps)
                steps = 0
                L*= 2
                H*= 2
            elif L>= half_range:
                encoded_bits.extend([1])
                encoded_bits.extend([0] * steps)
                steps = 0
                L= 2 * (L- half_range)
                H= 2 * (H- half_range)
            elif L>= quarter_range and H < 3 * quarter_range:
                steps += 1
                L= 2 * (L- quarter_range)
                H= 2 * (H- quarter_range)
            else:
                break

    steps += 1
    if L<= quarter_range:
        encoded_bits.extend([0])
        encoded_bits.extend([1] * steps)
    else:
        encoded_bits.extend([1])
        encoded_bits.extend([0] * steps)

    return encoded_bits, symbol_freq_dict






def arithmetic_decode(encoded_bits, symbol_freq_dict, precision=32):
    """
    Decode the encoded bits using the arithmetic coding algorithm.

    Args:
        encoded_bits (list): Encoded binary stream.
        symbol_freq_dict (dict): Symbol frequencies dictionary.
        precision (int): Number of precision bits used in the decoder.

    Returns:
        list: Decoded symbol stream.
    """
    bits_count = len(encoded_bits)
    stream_size = sum(symbol_freq_dict.values())
    full_range = 2**precision
    half_range = full_range // 2
    quarter_range = half_range // 2

    L= 0
    H= full_range
    value = 0
    index = 1

    decoded_stream = []

    while index <= precision and index <= bits_count:
        if encoded_bits[index - 1] == 1:
            value = value + 2**(precision - index)
        index += 1
    end_flag = 1

    while end_flag:
        for symbol, symbol_freq in symbol_freq_dict.items():
            S_high = cumulative_frequency(symbol, symbol_freq_dict)
            S_low = S_high- symbol_freq

            current_range = H - L

            upper_limit_calc = L+ current_range * S_high // stream_size
            lower_limit_calc = L+ current_range * S_low // stream_size

            if lower_limit_calc <= value < upper_limit_calc:
                decoded_stream.extend([symbol])
                L= lower_limit_calc
                H= upper_limit_calc
                if symbol == 'O':
                    end_flag = 0
                break

        while True:
            if H< half_range:
                L*= 2
                H*= 2
                value *= 2
                if index <= bits_count:
                    value += encoded_bits[index - 1]
                    index += 1
            elif L>= half_range:
                L= 2 * (L - half_range)
                H= 2 * (H - half_range)
                value = 2 * (value - half_range)
                if index <= bits_count:
                    value += encoded_bits[index - 1]
                    index += 1
            elif L>= quarter_range and H < 3 * quarter_range:
                L= 2 * (L - quarter_range)
                H= 2 * (H - quarter_range)
                value = 2 * (value - quarter_range)

                if index <= bits_count:
                    value += encoded_bits[index - 1]
                    index += 1
            else:
                break

    decoded_stream.pop()
    return decoded_stream



def flatten_array(array):
    """
    Flatten a 2D array to a 1D list.

    Args:
        array (np.ndarray): Input 2D array.

    Returns:
        list: Flattened 1D list.
    """
    return array.flatten().tolist()



def reshape_to_array(flat_stream, original_shape):
    """
    Reshape a flat stream to the original array shape.

    Args:
        flat_stream (list): Flattened input stream.
        original_shape (tuple): Shape of the original array.

    Returns:
        np.ndarray: Reshaped array.
    """
    return np.array(flat_stream).reshape(original_shape)




original_array = np.random.randint(0, 256, size=(2, 8, 8), dtype=np.uint8)
print("Original Array:")
print(original_array, "\n")

flat_stream = flatten_array(original_array)
print("Flattened Stream:")
print(flat_stream, "\n")

encoded_stream, dictionary = arithmetic_encode(flat_stream)
print("Encoded Stream:")
print(encoded_stream, "\n")
print("Symbol Frequencies:")
print(dictionary, "\n")

decoded_stream = arithmetic_decode(encoded_stream, dictionary)
print("Decoded Stream:")
print(decoded_stream, "\n")

decoded_array = reshape_to_array(decoded_stream, original_array.shape)
print("Decoded Array:")
print(decoded_array, "\n")

print("Original and Decoded Arrays are the same:", np.array_equal(original_array, decoded_array))
