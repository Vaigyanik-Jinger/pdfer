import os
from PIL import Image
from imagehash import phash

def find_duplicates(directory, threshold=0):
    # Create a dictionary to store image hashes and file paths
    hash_dict = {}
    duplicates = []

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.lower().endswith((".jpg", ".jpeg", ".png", ".bmp", ".gif")):
                file_path = os.path.join(root, file)
                with Image.open(file_path) as img:
                    img_hash = str(phash(img))
                if img_hash in hash_dict:
                    duplicates.append(file_path)
                else:
                    hash_dict[img_hash] = phash(img)

    return duplicates

def remove_duplicates(duplicate_list):
    for duplicate in duplicate_list:
        print(f"Removing duplicate: {duplicate}")
        os.remove(duplicate)

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python remove_duplicates.py <directory> <threshold>")
        sys.exit(1)
    directory_to_scan = sys.argv[1]
    threshold = int(sys.argv[2])

    duplicate_files = find_duplicates(directory_to_scan, threshold)

    if duplicate_files:
        print(f"Found {len(duplicate_files)} duplicate images:")
        for duplicate in duplicate_files:
            print(duplicate)
        #confirmation = input("Do you want to delete them? (yes/no): ").strip().lower()
        confirmation = "yes"
        if confirmation == "yes":
            remove_duplicates(duplicate_files)
            print("Duplicates removed.")
        else:
            print("No files were deleted.")
    else:
        print("No duplicate images found.")

