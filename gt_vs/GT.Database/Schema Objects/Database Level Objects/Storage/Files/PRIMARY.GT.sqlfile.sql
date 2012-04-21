ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [GT], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', MAXSIZE = UNLIMITED, FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];

