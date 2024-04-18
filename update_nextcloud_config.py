# Open the file and read its contents
file_path = '/mnt/nextcloud-dp/nextcloud/config/config.php'

with open(file_path, 'r') as file:
    lines = file.readlines()

# Find the index of the line containing ');' starting from the end
index_to_insert = None
for i in range(len(lines)-1, -1, -1):
    if ');' in lines[i]:
        index_to_insert = i
        break

# Define the lines to be inserted
lines_to_insert = [
    "  'htaccess.RewriteBase' => '/',\n",
    "  'htaccess.IgnoreFrontController' => true,\n",
    "  'defaultapp' => 'hip',\n",
    "  'trusted_domains' => ['hip.local'],\n"
]

# Insert the lines at the found index
if index_to_insert is not None:
    for line in reversed(lines_to_insert):
        lines.insert(index_to_insert, line)

# Save the file with the modifications
with open(file_path, 'w') as file:
    file.writelines(lines)

"Lines inserted and file saved successfully."
