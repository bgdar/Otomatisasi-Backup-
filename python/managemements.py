import os
import platform

class ManagementBakup:
    def __init__(self,targetPath:str,currentPath:str):
        '''targetPath = pat yang akan menjadi tempan file atau folder di bakup 
            current path = path yang akan di bakup'''
        self.targetPath = targetPath
        self.currentPath = currentPath

    def onSave(self):
        '''fn untuk mengcopy ke path target y'''
        if platform.system() == "Linux" or platform.system()== "Darwin":
            os.system("cp ",self.currentPath," ",self.targetPath)
        elif platform.system() == "Windows":
            os.system("copy",self.currentPath," ",self.targetPath)

    def cekPath(self) -> bool:
        '''cek apakah target path ini  ada apa tidak '''
        return os.path.isdir(self.targetPath) 
