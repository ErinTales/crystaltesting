def compare_files(file1, file2, sym_file):
    # Open files and read their bytes
    with open(file1, "rb") as f1, open(file2, "rb") as f2:
        bytes1 = f1.read()
        bytes2 = f2.read()

    # Check lengths
    if len(bytes1) != len(bytes2):
        raise ValueError("Files are not of the same length.")

    # Find the first 8 consecutive bytes that are different
    diff_address = None
    for i in range(len(bytes1) - 7):
        if all(bytes1[i+j] != bytes2[i+j] for j in range(8)):
            diff_address = i
            break

    if diff_address is None:
        print("No differing bytes found.")
        return

    # Print the differing bytes
    print("Differing bytes:")
    print("Bank:Address  pokecrystal-jp.gbc  baserom.gbc")
    for i in range(diff_address, diff_address + 8):
        bank = i // 0x4000
        address = i % 0x4000
        if bank != 0:
            address += 0x4000
        print(f"{bank:02X}:{address:04X}  {bytes1[i]:02X}  {bytes2[i]:02X}")

    # Find the closest symbol from the sym file
    closest_symbol = None
    closest_address = -1
    with open(sym_file, "r") as sf:
        for line in sf:
            if line.startswith(';'):  # skip comment lines
                continue
            parts = line.strip().split()
            bank = int(parts[0].split(':')[0], 16)
            address = int(parts[0].split(':')[1], 16)
            symbol = parts[1]
            if address > 0x7FFF:  # skip addresses beyond the ROM address space
                continue
            current_address = bank * 0x4000 + (address if address < 0x4000 else address - 0x4000)
            if current_address > closest_address and current_address <= diff_address:
                closest_address = current_address
                closest_symbol = symbol

    if closest_symbol is None:
        print("No symbol found before differing bytes.")
    else:
        bank = closest_address // 0x4000
        address = closest_address % 0x4000 + (0x4000 if bank != 0 else 0)
        print("The closest symbol before differing bytes is at address:",
              f"{bank:02X}:{address:04X}", "and is:", closest_symbol)


# Usage
compare_files('pokecrystal.gbc', 'baserom.gbc', 'pokecrystal.sym')

