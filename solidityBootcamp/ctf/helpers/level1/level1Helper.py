import json

def splitCalldata(calldata):
    if calldata.startswith('0x'):
        calldata = calldata[2:]
    
 
    memory_layout = {}
    chunk_size = 64  # 32 bytes represented as 64 hex characters
    offset = 0
    index = 0  # Memory index in bytes
    
    # Process full 64-character chunks
    while offset + chunk_size <= len(calldata):
        chunk = calldata[offset:offset + chunk_size]
        memory_layout[hex(index)] = f'0x{chunk}'
        offset += chunk_size
        index += 32  # Each chunk occupies 32 bytes in memory
    
    # Process remaining data (less than 64 characters)
    if offset < len(calldata):
        remaining = calldata[offset:]
        memory_layout[hex(index)] = f'0x{remaining}'+ '0'*(64- len(remaining))
    
    return memory_layout

if __name__ == "__main__":
    calldata = input("Enter the calldata: ").strip()
    result = splitCalldata(calldata)
    with open("helpers/level1/memoryLayout.json", "w") as fp:
        json.dump(result, fp, indent=4)