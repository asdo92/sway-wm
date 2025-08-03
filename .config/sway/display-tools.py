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
    master.title("Display-Tools.py")

    # Set theme and window size
    master.configure(bg='#23283f')
    master.geometry('350x315')

    self.boton1 = tk.Button(master, text="Run wdisplays", command=self.exec_command1, bg='#205d2c', fg="white")
    self.boton1.pack(side=tk.TOP, pady=10)

    self.boton2 = tk.Button(master, text="Run ~/.config/sway/startwlrrandr.sh", command=self.exec_command2, bg='#205d2c', fg="white")
    self.boton2.pack(side=tk.TOP, pady=10)

    self.boton3 = tk.Button(master, text="Run ~/.config/sway/wayland-screenshot", command=self.exec_command3, bg='#205d2c', fg="white")
    self.boton3.pack(side=tk.TOP, pady=10)

    self.boton4 = tk.Button(master, text="Run ~/.config/sway/wayland-recorder", command=self.exec_command4, bg='#205d2c', fg="white")
    self.boton4.pack(side=tk.TOP, pady=10)

    self.boton5 = tk.Button(master, text="Start/Restart nwg-wrapper (conky sway)", command=self.exec_command5, bg='#205d2c', fg="white")
    self.boton5.pack(side=tk.TOP, pady=10)
    
    self.boton6 = tk.Button(master, text="Exit", command=self.exec_command6, bg='#205d2c', fg="white")
    self.boton6.pack(side=tk.TOP, pady=10)

    # Set center buttons
    self.boton1.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton2.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton3.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton4.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton5.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)
    self.boton6.pack(side=tk.TOP, padx=10, pady=10, fill=tk.BOTH)

  def exec_command1(self):
    print('# Run wdisplays')
    command = "wdisplays"
    os.system(command)

  def exec_command2(self):
    print('# Run ~/.config/sway/startwlrrandr.sh')
    command = "~/.config/sway/startwlrrandr.sh"
    os.system(command)

  def exec_command3(self):
    print('# Run ~/.config/sway/wayland-screenshot')
    command = "~/.config/sway/wayland-screenshot"
    os.system(command)

  def exec_command4(self):
    print('# Run ~/.config/sway/wayland-recorder')
    command = "~/.config/sway/wayland-recorder"
    os.system(command)

  def exec_command5(self):
    print('# Start/Restart nwg-wrapper (conky sway)')
    command = "~/.config/sway/nwg-wrapper-conky.sh"
    os.system(command)

  def exec_command6(self):
    command = "exit"
    os.system(command)
    exit()

root = tk.Tk()
window = MainWindow(root)
root.mainloop()
