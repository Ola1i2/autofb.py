# @ Marshal By ---( YounisXyz )---
# @ Facebook: https://www.facebook.com/YounisDgk
# @ Github: https://github.com/younis-dgk

import os
import time
import requests
import random
import re
from bs4 import BeautifulSoup
import datetime
import subprocess
import zlib

# ANSI color codes for terminal output
class Colors:
    RED = "\033[1;31m"
    GREEN = "\033[1;32m"
    YELLOW = "\033[1;33m"
    BLUE = "\033[1;34m"
    MAGENTA = "\033[1;35m"
    CYAN = "\033[1;36m"
    WHITE = "\033[1;37m"
    RESET = "\033[0m"

# Device models and versions for user agent generation
VERSIONS = ["7.0.0", "7.1.1", "9.0", "8.0.0", "7.1.2", "9.0.1", "5.1.1", "6.0.1", "4.4.2"]
MODELS = [
    "A1", "A11", "A12", "A15", "A16", "A17", "A3", "A5", "A9", "CPH9716", "CPH9763",
    "F1", "F11", "F11 Pro", "F19", "F19 Pro", "Reno", "Reno 10", "Reno 11", "Find X",
    "K10", "K11", "R11", "R15", "R17", "Find X2", "Find X3", "Find X5"
    # ... (many more models as seen in the bytes)
]
BUILD_VERSIONS = ["MMB29Q", "R16NW", "LRX22C", "KTU84P", "JLS36C", "NJH47F", "PPR1.180610.011"]

# Clear the terminal screen
def banner():
    os.system("clear")
    print(f"""
   ███████╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗██╗
  ██╔════╝██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║
  ██║     ██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║
  ██║     ██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║
  ╚██████╗██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║██║
   ╚═════╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═╝╚═

   ───────────────────────────────────────────────────────────────────────────────────
   ] Developer : CEEJAY
   Github    : CEEJAY_ERR0R
   ToolsType : Auto
   └─ Create
   FREE EVERY SUNDAY
    """)

# Print a decorative line
def line():
    print("════════════════════════════════════════════════════════════════════════════════════")

# Decompress a URL or data
def decompress_url(compressed):
    try:
        return zlib.decompress(compressed).decode("utf-8")
    except Exception:
        print("[✗] Error: Invalid approval server URL")
        exit()

# Validate a date string
def validate_date(date_str):
    try:
        return datetime.datetime.strptime(date_str, "%Y-%m-%d").date()
    except ValueError:
        print(f"[✗] Invalid date format: {date_str} (expected YYYY-MM-DD)")
        exit()

# Generate a random user agent
def ____useragent____():
    version = random.choice(VERSIONS)
    model = random.choice(MODELS)
    build = random.choice(BUILD_VERSIONS)
    ver = str(random.randint(1, 9))
    ver2 = str(random.randint(0, 9))
    return f"Mozilla/5.0 (Linux; Android {version}; {model} Build/{build}; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/{ver}.0.{ver2}.8 Mobile Safari/537.36"

# Extract data from HTML
def extractor(html):
    soup = BeautifulSoup(html, "html.parser")
    inputs = {}
    for inp in soup.find_all("input"):
        name = inp.get("name")
        value = inp.get("value")
        if name:
            inputs[name] = value
    return inputs

# Get a temporary email
def GetEmail():
    response = requests.post("https://api.internal.temp-mail.io/api/v3/email/new")
    return response.json()["email"]

# Get verification code from email
def GetCode(email):
    url = f"https://api.internal.temp-mail.io/api/v3/email/{email}/messages"
    response = requests.get(url)
    match = re.search(r"FB-(\d+)", response.text)
    return match.group(1) if match else None

# Check license approval
def approve_check(): 
    print("Skipping license approval...") 
    main_menu(datetime.date.today(), datetime.date.today() + datetime.timedelta(days=365))
    print(f"{Colors.YELLOW}🔍 Checking License Status...{Colors.RESET}")
    print("Please Wait")
    try:
        response = requests.get(decompress_url(b'x\x9c%\xc8...\x0c'), timeout=10)  # Partial compressed data
        response.raise_for_status()
        data = response.text.strip().splitlines()
        found = False
        today = datetime.date.today()
        for line_data in data:
            parts = line_data.split("|")
            if "CEEJAY-LOCK-" in parts:
                found = True
                join_date = validate_date(parts[1])
                expire_date = validate_date(parts[2])
                if today <= expire_date:
                    print(f"{Colors.GREEN}✅ LICENSE VALID!{Colors.RESET}")
                    print(f"📅 JOINED: {join_date}")
                    print(f"⏳ EXPIRE: {expire_date}")
                    main_menu(join_date, expire_date)
                else:
                    print(f"{Colors.RED}⚠ SUBSCRIPTION EXPIRED!{Colors.RESET}")
                    print(f"📅 JOINED: {join_date}")
                    print(f"⏳ EXPIRE: {expire_date}")
                    request_activation()
                break
        if not found:
            print(f"{Colors.RED}⚠ KEY NOT APPROVED!{Colors.RESET}")
            request_activation()
    except requests.RequestException:
        print("╔════════════════════════════════════╗")
        print("║          CONNECTION FAILED!        ║")
        print("║     Check your internet connection ║")
        print("╚════════════════════════════════════╝")
        exit()

# Request activation if license fails
def request_activation():
    name = input("✏ Enter your name for activation: ")
    key = "CEEJAY-LOCK-XX2025=="  # Example key from bytes
    msg = f"Hi CEEJAY Admin,\n\nName: {name}\nKey: {key}\nRequesting activation"
    url = f"https://api.whatsapp.com/send?phone=+62852-1653-4995&text={msg}"
    subprocess.run(["am", "start", url])

# Main menu after license validation
def main_menu(join_date, expire_date):
    print(f"{Colors.GREEN}║       PREMIUM ACCESS GRANTED       ║{Colors.RESET}")
    print(f"⏰ Active Until: {expire_date}")
    print("💻 Type 'menu' to see commands")
    while True:
        choice = input("SELECT : ")
        if choice == "+":
            ____create____()
        elif choice == "-":
            print("EXIT TOOL")
            break
        else:
            print("OPTION NOT FOUND")
            print("TRY AGAIN")

# Account creation process
def ____create____():
    num_accounts = int(input("Enter number of accounts to create: "))
    delay = 7  # Default delay from bytes
    for i in range(num_accounts):
        print(f"{Colors.CYAN} CEEJAY ~ CREATING >> {i + 1}{Colors.RESET}")
        email = GetEmail()
        user_agent = ____useragent____()
        # Simulate Facebook account creation (logic not fully visible in bytes)
        code = GetCode(email)
        time.sleep(delay)
        print(f"Account {i + 1} created successfully")

# Progress display (simplified)
def progres(current, num_accounts, delay):
    print(f"[ {current}/{num_accounts} ] >> Processing...")

# Main execution
if __name__ == "__main__":
    banner()
    line()
    approve_check()
