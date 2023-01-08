#gather information about machine and its installed SW

# Get the current date and time
$date = Get-Date

# Get the operating system information
$os = Get-WmiObject -Class Win32_OperatingSystem

# Get the installed software
$software = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version

# Get the system performance
$cpu = Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, NumberOfCores, NumberOfLogicalProcessors
$memory = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
$disk = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object -Property DeviceID, FreeSpace, Size

# Output the results
"==== OS Information ===="
"  * Operating System: $($os.Caption)"
"  * Version: $($os.Version)"
"  * Manufacturer: $($os.Manufacturer)"
"  * Build Number: $($os.BuildNumber)"

"==== Installed Software ===="
"<code>"
$software
"</code>"

"==== System Performance ==== "

"  * CPU: $($cpu.Name) with $($cpu.NumberOfCores) cores and $($cpu.NumberOfLogicalProcessors) logical processors"
"  * Memory: $([Math]::Round(($memory.Sum / 1GB), 2)) GB"
"Disk Space: "
"<code>"
$disk | Format-Table -AutoSize
"</code>"
