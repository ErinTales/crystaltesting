import numpy as np

def compare_banks(file1, file2, bank_size=0x4000):
    with open(file1, 'rb') as f1, open(file2, 'rb') as f2:
        bank_num = 0
        total_banks = min(len(f1.read()) // bank_size, len(f2.read()) // bank_size)
        f1.seek(0)
        f2.seek(0)
        total_percentage = 0
        while True:
            bank1 = np.fromfile(f1, dtype=np.uint8, count=bank_size)
            bank2 = np.fromfile(f2, dtype=np.uint8, count=bank_size)
            if len(bank1) == 0 or len(bank2) == 0:
                break
            comparison = bank1 == bank2
            percentage = np.mean(comparison) * 100
            total_percentage += percentage
            print(f'Bank #{bank_num:02X} match: {percentage:.2f}%')
            bank_num += 1
        print(f'Overall match: {total_percentage / total_banks:.2f}%')

# Run the comparison
compare_banks('pokecrystal.gbc', 'baserom.gbc')

