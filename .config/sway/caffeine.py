#!/usr/bin/env python3

import tkinter as tk
import os
import psutil

def check_process_running(process_name):
    for proc in psutil.process_iter(['name']):
        if proc.info['name'] == process_name:
            return True
    return False

class MainWindow:
  def __init__(self, master):
    self.master = master
    master.title("Caffeine.py")

    # Set theme and window size
    master.configure(bg='#262321')
    master.geometry('250x215')

    self.boton1 = tk.Button(master, text="Enable Caffeine Mode", command=self.exec_command1, bg='#703207', fg="white")
    self.boton1.pack(side=tk.TOP, pady=10)

    self.boton2 = tk.Button(master, text="Disable Caffeine Mode", command=self.exec_command2, bg='#703207', fg="white")
    self.boton2.pack(side=tk.TOP, pady=10)

    self.boton3 = tk.Button(master, text="Check Status", command=self.exec_command3, bg='#703207', fg="white")
    self.boton3.pack(side=tk.TOP, pady=10)
    
    self.boton4 = tk.Button(master, text="Exit", command=self.exec_command4, bg='#703207', fg="white")
    self.boton4.pack(side=tk.TOP, pady=10)

    # Set center buttons
    self.boton1.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton2.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton3.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton4.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)

  def exec_command1(self):
    print('# Enabled Caffeine Mode')
    command = "killall startwlrscreensaver.sh 2> /dev/null"
    os.system(command)
    command = "killall swayidle 2> /dev/null"
    os.system(command)

  def exec_command2(self):
    command = "killall startwlrscreensaver.sh 2> /dev/null"
    os.system(command)
    command = "killall swayidle 2> /dev/null"
    os.system(command)
    command = "~/.config/sway/startwlrscreensaver.sh &"
    os.system(command)
    print('# Disabled Caffeine Mode')

  def exec_command3(self):
    message = tk.Tk()
    message.title("Caffeine.py")

    # Set theme and window size
    message.configure(bg='#262321')
    message.geometry('190x105')

    # Verificar si el proceso swayidle está en ejecución
    if check_process_running("swayidle"):
        label = tk.Label(message, text="Caffeine Mode is Disabled.", bg='#703207', fg="white")
    else:
        label = tk.Label(message, text="Caffeine Mode is Enabled.", bg='#703207', fg="white")
    # Show window message
    label.pack(side=tk.TOP, pady=10)
    # Add close button
    button = tk.Button(message, text="Close", command=message.destroy, bg='#703207', fg="white")
    button.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    # Init events bucle
    message.mainloop()

  def exec_command4(self):
    command = "exit"
    os.system(command)
    exit()

root = tk.Tk()
window = MainWindow(root)
root.mainloop()
