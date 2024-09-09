import zipfile
import os

TEST_DIR = 'testZips'

os.makedirs(TEST_DIR, exist_ok=True)

def create_test_zip(file_name, num_files, size_per_file):
    with zipfile.ZipFile(file_name, 'w', zipfile.ZIP_DEFLATED) as z:
        for i in range(num_files):
            file_content = 'A' * size_per_file
            z.writestr(f'file_{i}.txt', file_content)

create_test_zip('testZips/normal.zip', 10, 100)
create_test_zip('testZips/zip_bomb.zip', 1, 1_000_000) 

os.listdir('testZips')