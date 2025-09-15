import time, sys

def main():
    with open("/opt/infinity_loop/logs/conduit.log", "a") as f:
        f.write(f"🧠 Heartbeat at {time.ctime()}\n")
    print("🧠 Infinity Loop heartbeat cycle...")

if __name__ == "__main__":
    main()
