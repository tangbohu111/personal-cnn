#coding=UTF-8
file_path1 = 'weights1_IEEE.txt'  # 文件路径
memory1 = {}  # 存储文件内容的字典

# 读取文件并添加到memory字典中
with open(file_path1, 'r') as file:
    lines1 = file.readlines()  # 读取所有行

for i, line in enumerate(lines1):  # 遍历所有行并添加到memory字典中
    memory1[i] = line.strip()  # 将每一行的内容去除空格和换行符后添加到字典中

# 将memory字典中的内容写入到.v文件中
with open('weights1_IEE.v', 'w') as output_file:
    output_file.write("always@(*) begin\n")  # 添加头部语句
    for key1 in memory1:
        output_file.write("    memory[%d] = 32'h%s ;\n" %(key1,memory1[key1]))       
    output_file.write("end\n")  # 添加尾部语句

print("memgen1 finished!")


file_path2 = 'weights2_IEEE.txt'  # 文件路径
memory2 = {}  # 存储文件内容的字典

# 读取文件并添加到memory字典中
with open(file_path2, 'r') as file:
    lines2 = file.readlines()  # 读取所有行

for i, line in enumerate(lines2):  # 遍历所有行并添加到memory字典中
    memory2[i] = line.strip()  # 将每一行的内容去除空格和换行符后添加到字典中

# 将memory字典中的内容写入到.v文件中
with open('weights2_IEE.v', 'w') as output_file:
    output_file.write("always@(*) begin\n")  # 添加头部语句
    for key2 in memory2:
        output_file.write("    memory[%d] = 32'h%s ;\n" %(key2,memory1[key2]))       
    output_file.write("end\n")  # 添加尾部语句

print("memgen2 finished!")


file_path3 = 'weights3_IEEE.txt'  # 文件路径
memory3 = {}  # 存储文件内容的字典

# 读取文件并添加到memory字典中
with open(file_path3, 'r') as file:
    lines3 = file.readlines()  # 读取所有行

for i, line in enumerate(lines3):  # 遍历所有行并添加到memory字典中
    memory3[i] = line.strip()  # 将每一行的内容去除空格和换行符后添加到字典中

# 将memory字典中的内容写入到.v文件中
with open('weights3_IEE.v', 'w') as output_file:
    output_file.write("always@(*) begin\n")  # 添加头部语句
    for key3 in memory3:
        output_file.write("    memory[%d] = 32'h%s ;\n" %(key3,memory3[key3]))       
    output_file.write("end\n")  # 添加尾部语句

print("memgen3 finished!")


