#! bin/bash/

echo "Welcome to PDFer:- A CLI tool that converts MP4 files to PDFs. Created by Harsh Jinger. I hope it helps."

mkdir temp
cp $1.mp4 temp/
cd temp
echo "Please identify the timestamps where you want to start and end the transcription process."
read -p "Enter the starting time (hh:mm:ss): " start_time
read -p "Enter the ending time (hh:mm:ss): " end_time
echo "Please identify the co-ordinates of the top-left and bottom-right corners of the screen that you want to grasp in the PDF." | lolcat
echo "hover your mouse pointer over the image once the Image is displayed." 
ffmpeg -i $1.mp4 -ss $start_time -vframes 1 starting_frame.png
geeqie starting_frame.png &
wait
rm starting_frame.png
read -p "Enter x1 y1 x2 y2 (top-left x, top-left y, bottom-right x, bottom-right y): " x1 y1 x2 y2
width=$((x2 - x1))
height=$((y2 - y1))
ffmpeg_command="ffmpeg -i $1.mp4 -ss $start_time -to $end_time -vf \"select=not(mod(n\,30)),crop=$width:$height:$x1:$y1\" -vsync vfr out_%08d.png"
eval $ffmpeg_command | lolcat
echo "Frames extracted and cropped successfully."
cd ..
rdfind -deleteduplicates true -makeresultsfile false temp | lolcat
python simpics.py temp 0 | lolcat
cd temp
counter=1
for file in *.png; do
  new_name="$counter.png"
  mv -v "$file" "$new_name" | lolcat
  ((counter++))
done
ls *png | sort -n | lolcat
echo "You have to type the name of the files that you want to delete. Note them down somewhere separated by spaces" | lolcat
geeqie .
read -p "Enter the file names (without extensions) to delete, separated by space: " file_names
IFS=' ' read -ra files_to_delete <<< "$file_names"
for file in "${files_to_delete[@]}"; do
    if [ -e "$file.png" ]; then
        rm "$file.png"
        echo "Deleted: $file.png" | lolcat
    else
        echo "File not found: $file.png" | lolcat
    fi
done

count=1
for file in $(ls *.png | sort -n); do
    new_name=$(printf "%03d.png" "$count")
    mv "$file" "$new_name"
    ((count++))
done

convert *.png $1.pdf
echo "Success! The PDF has been generated!" | lolcat
ls *.pdf | lolcat
mv $1.pdf ./..
cd ..
rm -r temp
evince $1.pdf
