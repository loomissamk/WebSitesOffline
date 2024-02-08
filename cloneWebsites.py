import os
import subprocess
from multiprocessing import Pool

# List of websites
websites_group= [
    "https://www.webmd.com/",
    "https://www.sciencedaily.com/",
    "https://www.wikipedia.org/",
    "https://www.ifixit.com/",
    "https://www.engineeringtoolbox.com/",
    "https://www.allaboutcircuits.com/",
    "https://stackoverflow.com/",
    "https://www.wildfooduk.com/edible-wild-plants/"
]

# Root folder to create website folders
ROOT_FOLDER = "/home/bat/Desktop/WebSites"

def process_website(website):
    website_name = website.split("www.")[-1].split(".")[0]
    website_folder = os.path.join(ROOT_FOLDER, website_name)
    os.makedirs(website_folder, exist_ok=True)
    dockerfile_path = os.path.join(website_folder, "Dockerfile")
    with open(dockerfile_path, "w") as dockerfile:
        dockerfile.write(f"FROM ubuntu:latest\n"
                         f"RUN apt-get update && apt-get install -y httrack\n"
                         f"WORKDIR /\n"
                         f"RUN httrack {website} -O /{website_name} --mirror\n")
    subprocess.run(["docker", "build", "-t", f"{website_name}_mirror", website_folder])
    subprocess.run(["docker", "run", "--rm", f"{website_name}_mirror"])
    return website_name, website_folder

if __name__ == "__main__":
    # Create a pool of workers
    with Pool(processes=len(websites_group)) as pool:
        # Execute each website processing function in parallel
        results = pool.map(process_website, websites_group)

    # Create bookmark HTML file
    with open("bookmarks.html", "w") as bookmark_file:
        bookmark_file.write("<html><head><title>Local Website Bookmarks</title></head><body><h1>Local Website Bookmarks</h1><ul>")
        for website_name, website_folder in results:
            bookmark_file.write(f"<li><a href=\"file://{os.path.abspath(os.path.join(website_folder, 'index.html'))}\">{website_name}</a></li>")
        bookmark_file.write("</ul></body></html>")

print("Website cloning, Dockerfile execution, and bookmark generation completed successfully.")
