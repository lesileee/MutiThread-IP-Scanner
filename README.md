# MultiThread IP Scanner

A lightweight IP scanner implemented in Batch script that performs parallel ping tests across a specified IP range.

## Features

- Multi-threaded scanning (up to 20 concurrent threads)
- Simple IP range input format
- Results output to both console and report file
- Basic online/offline status detection

## Usage

1. Run the script (`IP_SCANNER.bat`)
2. Enter the IP range in format: `192.168.1.1-192.168.1.254`
3. View real-time results in console
4. Find sorted results in `REPORT.TXT`

## Technical Details

- ​**Implementation**: Pure Batch script (CMD)
- ​**Threading**: Achieved through parallel process spawning
- ​**Output**: 
  - Console shows real-time unordered results
  - Report file contains sorted final results
- ​**Dependencies**: 
  - Native Windows commands (`ping`, `findstr`)
  - PowerShell (for sorting functionality)

## Known Limitations

1. No strict IP range format validation
2. Console output may appear disordered due to threading
3. Sorting relies on PowerShell as Batch implementation is cumbersome
4. Currently only detects online status (could be extended to capture latency)

## Future Improvements

- Add input validation for IP ranges
- Implement pure Batch sorting solution
- Extract and display latency statistics
- Add timeout configuration
- Implement CIDR notation support


## License

Free to use and modify. Credit to original author appreciated.
