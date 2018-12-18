# Build README.md file


from os import walk, sep
from os.path import join

print("Writing README file...")

src_dir = "." + sep + "src"
link_dir = "src/"

readme_src = ["# RbxCookbook\n", "Feel free to submit a pull request with your own contributions!\n"]

# Get source files:
(_, _, filenames) = walk(src_dir).next()

def get_filename_without_ext(filename):
	dot = filename.rfind(".")
	if dot != -1:
		filename = filename[:dot]
	return filename

# Create list:
readme_src.append("### Snippets\n")
for filename in filenames:
	name = get_filename_without_ext(filename)
	anchor_name = name
	anchor_name = "".join(e for e in anchor_name if e.isalnum()).lower()
	readme_src.append(" - [" + filename + "](#" + anchor_name + ")")

readme_src.append("");

# Collect source code:
first = True
for filename in filenames:
	filepath = join(src_dir, filename)
	with open(filepath) as f:
		source = f.read()
		name = get_filename_without_ext(filename)
		src_file_link = link_dir + filename
		if not first:
			readme_src.append("----------\n\n")
		else:
			first = False
		readme_src.append("### " + name + "\n[`" + filename + "`](" + src_file_link + ")\n")
		readme_src.append("```lua\n" + source + "\n```\n")

# Write readme file:
with open("README.md", "w") as readme_file:
	readme_src_str = "\n".join(readme_src)
	readme_file.write(readme_src_str)

print("README written")