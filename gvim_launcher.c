#include <windows.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    STARTUPINFOA si;
    PROCESS_INFORMATION pi;
    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    // Build the command line.
    // If you want to pass a filename as an argument, check argc.
    const char* fileArg = (argc > 1) ? argv[1] : "";
    char cmdLine[1024];
    // Make sure to adjust the path to your gvim.exe as needed.
    snprintf(cmdLine, sizeof(cmdLine),
        "\"D:\\pathto\\Vim\\vim82\\gvim.exe\" --servername GVIM --remote-tab-silent \"%s\"",
        fileArg);

    // Create the process that brings GVIM server with the same file opened to foreground.
    if (!CreateProcessA(NULL, cmdLine, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi)) {
        fprintf(stderr, "CreateProcess failed (%d).\n", GetLastError());
        return 1;
    }
    // Close process and thread handles.
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return 0;
}
