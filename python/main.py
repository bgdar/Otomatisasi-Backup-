from rich.console import Console
from rich.table import Table
from rich.layout import Layout
from rich.panel import Panel

import time
from managemements import ManagementBakup


layout = Layout()
console = Console()

layout.split(
        Layout(name="header",size=4),
        Layout(name="section",ratio=2)
        )
layout["section"].split_row(
        Layout(name="sectionKiri"),
        Layout(name="SectionKanan")
        )

tableInformation = Table(title="[bold #006400] Daftar Information]", pad_edge=True)
# inisialiasi table kosong dulu  
tableInformation.add_column("Current Path", justify="center")
tableInformation.add_column("Target Path", justify="center")
tableInformation.add_column("DeadLine")
tableInformation.add_column("Spead Bakup")


layout["header"].update(Panel("OTOMATISASI BAKUP ",style="bold #184b44"))

layout["sectionKiri"].update(tableInformation)
layout["SectionKanan"].update(Panel("tetst"))



# jalanakan di bawah atau di file utaman "main file"
if __name__ == "__main__":
    console.print(layout)

    while True:
    # tampilkan tablebugreportsdata
        
        console.print("[#000000 on #eaeaea]masukan path tempat bakup data")
        targetPath = console.input("")
        console.rule("")

        console.print(" masukan path yang kana di bakup")
        currentPath = console.input("")

        management = ManagementBakup(targetPath,currentPath)
        
        if management.cekPath():
            management.onSave()
        else:
            console.log("masukan yang benar path")
            tableInformation.add_column("wrong")
            tableInformation.add_row(targetPath)
        print(management.targetPath,management.currentPath)
        
        

        break
