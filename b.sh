clear
for file in *.asm; do
	if [ -f "$file" ]; then
		obj="${file%.asm}.o"
		nasm -o "$obj" -felf64 "$file"
	fi
done
ld -o main *.o
rm *.o
./main

