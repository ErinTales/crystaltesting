import sys
import numpy as np
import re

def parse_charmap(charmap_file):
    charmap = {}
    with open(charmap_file, 'r') as f:
        for line in f:
            match = re.match(r'\tcharmap "([^"]*)",\s+\$([0-9A-Fa-f]+)', line)
            if match:
                charmap[int(match.group(2), 16)] = match.group(1)
    return charmap

def parse_rom(rom_file, address):
    bank, offset = map(lambda x: int(x, 16), address.split(':'))
    offset += bank * 0x4000  # Each bank is 0x4000 bytes long
    with open(rom_file, 'rb') as f:
        f.seek(offset)
        data = []
        while True:
            byte = f.read(1)
            if not byte or byte[0] == 0x50:  # End of string or file
                break
            data.append(byte[0])
    return data

def convert_to_text(data, charmap):
    return ''.join(charmap.get(byte, '?') for byte in data)

def main():
    charmap_file = 'charmap.asm'
    rom_file = 'baserom.gbc'

    # get the address from command line argument
    if len(sys.argv) > 1:
        address = sys.argv[1]
    else:
        print("Please provide an address.")
        sys.exit(1)

    charmap = parse_charmap(charmap_file)
    data = parse_rom(rom_file, address)
    text = convert_to_text(data, charmap)
    print(text)

if __name__ == "__main__":
    main()

