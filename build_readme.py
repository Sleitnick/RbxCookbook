# Build README.md file


from os import walk, sep
from os.path import join

print("Writing README file...")

src_dir = "." + sep + "src"

readme_src = ["# RbxCookbook\n"]

# Collect source code:
(_, _, filenames) = walk(src_dir).next()
first = True
for filename in filenames:
	filepath = join(src_dir, filename)
	with open(filepath) as f:
		source = f.read()
		if not first:
			readme_src.append("----------\n\n")
		else:
			first = False
		readme_src.append("### " + filename + "\n")
		readme_src.append("```lua\n" + source + "\n```\n")

# Write readme file:
with open("README.md", "w") as readme_file:
	readme_src_str = "\n".join(readme_src)
	readme_file.write(readme_src_str)

print("README written")