<p align="center">
<h1><a href="https://thelibre.news">LibreNews</a> Tools by <a href="https://blahaj.land">blahaj.land</a>/<a href="https://discord.com/users/4165987115897663">eryn</a></h1>
</p>
<p align="center">
<img src="static/promo-image.png" alt="LibreNews x blahaj.land">
</p>
<p align="center">
A collection of tools for <a href="https://thelibre.news">LibreNews</a>.
</p>

---

Blahaj.Land is proud to power [LibreNews](https://thelibre.news), a new news platform owned by [Niccolo Venerandi](https://github.com/veggero), maintained by eryn from [blahaj.land](https://github.com/blahajland).

<div align="center">
    <img src="static/view-apps.png" width="30%" href="https://blahaj.land/yunohost/sso/">
    <img src="static/discord.png" width="30%" href="https://discord.blahaj.land">
    <img src="static/donations.png" width="30%" href="https://donate.blahaj.land">
</div>

## About
LibreNews runs a Ghost CMS instance, but since Ghost requires a pretty expensive bulkmail service, I have created a set of tools that allow Nicco to send newsletters to his subscribers without the use of Mailgun. <br>

## Tools
### Ghost - Listmonk subscriber sync
Fetches all subscribers from Ghost and syncs them to Listmonk while preserving their subscription status. Always in sync.

---
### Ghost - Listmonk article sync 
Fetches all articles from Ghost and syncs them to Listmonk as new campaigns.

---
### Markdown to Ghost article converter
Converts markdown files to Ghost articles and uploads them to the Ghost API. <br> 

This is by far the most complex tool in the set, as it has to handle uploading zip archives containing the Markdown files and their attachments, and then converting them to Ghost articles.

Made **specifically** for LibreNews, as it expects a certain file structure matching Nicco's workflow.

## How to use the tools

### Prerequisites
    - A server with python 3.11 installed
    - A Ghost instance
    - A Listmonk instance
    - A reverse proxy for the Md to Ghost article converter tool
      - By default, the converter runs on port 5001, you can change this by editing the `import_post.py` file 

### Installation
1. Clone the repository
2. Install the requirements
    ```bash
    pip install -r requirements.txt
    ```
3. Rename `config.example.conf` to `config.conf` and fill in the required fields
4. Additonally you are going to have to modify the `sync_articles.py ` and `sync_news_members.py` files to match your Ghost subscription tiers and Listmonk list IDs.<br> 
   This is because the tools were made specifically for LibreNews and are not very flexible. <br>
   I might make them more flexible in the future, but for now, you are going to have to modify the files yourself.

### Running the tools
1. Run the subscriber sync tool
    ```bash
    python sync_news_members.py
    ```
2. Run the article sync tool
    ```bash
    python sync_articles.py
    ```
3. Run the markdown to Ghost article converter
    ```bash
    python import_post.py
    ```


## Support
This project is focused entirely on LibreNews, and unfortunately I will not be providing support for other projects, as my day only has 24 hours. <br>
I'd be glad to look over any opened issues but please don't ask me for help. (I'm sorry)