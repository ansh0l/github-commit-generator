#!/bin/sh

#Echo usage
echo "########################"
echo "Run this script as:"
# echo "\t rm -rf .git/ && sh script.sh Anshul anshl.goyl@gmail.com https://github.com/ansh0l/github-commit-generator.git"
echo "\t sh script.sh <name> <email> <emptyrepo>"
echo "########################\n"

#Initialize git repository
echo "Initializing git repository"
git init
git config user.name "$1"
git config user.email "$2"
git remote add origin "$3"
echo "########################\n"


# Calculate start and end times for commits
echo "Calculating start and end times"
SECONDS_PER_DAY=86400
DAYS_AGO=400
CUR_EPOCH_TIME=`date "+%s"`
DELTA=`expr $DAYS_AGO \* $SECONDS_PER_DAY`
BEGIN_EPOCH_TIME=`expr $CUR_EPOCH_TIME - $DELTA`
END_EPOCH_TIME=`expr $CUR_EPOCH_TIME + $DELTA`
echo "Current Time: $CUR_EPOCH_TIME\nStart Time for Commits: $BEGIN_EPOCH_TIME\nEnd Time for Commits $END_EPOCH_TIME"
echo "########################\n"

# Create a Temp.file for commits

echo "Creating temp file and adding it to repo alongwith the script.sh file"
cat /dev/null > temp.file
OLD_EPOCH=$BEGIN_EPOCH_TIME
COMMIT_DATE=`date -r $OLD_EPOCH`
export GIT_AUTHOR_DATE=$COMMIT_DATE
export GIT_COMMITTER_DATE=$COMMIT_DATE
git add temp.file script.sh
git commit -m "Initial commit for $COMMIT_DATE"
echo "########################\n"


echo "Creating commits for every day in the range till today"
while [ $OLD_EPOCH -le $CUR_EPOCH_TIME ]
#while [ $OLD_EPOCH -le $BEGIN_EPOCH_TIME ]
do
	INCREMENT=`expr $RANDOM \* 3 % 84600`
	NEW_EPOCH=`expr $OLD_EPOCH + $INCREMENT`
	COMMIT_DATE=`date -r $NEW_EPOCH`

	LINES=`expr $RANDOM / 5000`
	echo "0 $COMMIT_DATE" > temp.file
	for LINE in $(seq 1 $LINES);
	do
		echo "$LINE $COMMIT_DATE" >> temp.file
	done

	git add temp.file

	export GIT_AUTHOR_DATE=$COMMIT_DATE
	export GIT_COMMITTER_DATE=$COMMIT_DATE
	git commit -m "commit for $COMMIT_DATE" --quiet
	OLD_EPOCH=$NEW_EPOCH
	#GIT_AUTHOR_DATE='Tue Nov 1 08:35:12 IST 2016' GIT_COMMITTER_DATE='Tue Nov 1 08:35:12 IST 2016' git commit -m 'commit for Tue Nov 1 08:35:12 IST 2016'
done
echo "########################\n"

echo "Force push the commits to the repository"
git push origin master -f
echo "########################\n"

echo "Creating commits for every day in the range from today onwards"
while [ $OLD_EPOCH -le $END_EPOCH_TIME ]
#while [ $OLD_EPOCH -le $BEGIN_EPOCH_TIME ]
do
	INCREMENT=`expr $RANDOM \* 3 % 84600`
	NEW_EPOCH=`expr $OLD_EPOCH + $INCREMENT`
	COMMIT_DATE=`date -r $NEW_EPOCH`

	LINES=`expr $RANDOM / 5000`
	echo "0 $COMMIT_DATE" > temp.file
	for LINE in $(seq 1 $LINES);
	do
		echo "$LINE $COMMIT_DATE" >> temp.file
	done

	git add temp.file

	export GIT_AUTHOR_DATE=$COMMIT_DATE
	export GIT_COMMITTER_DATE=$COMMIT_DATE
	git commit -m "commit for $COMMIT_DATE" --quiet
	OLD_EPOCH=$NEW_EPOCH
	#GIT_AUTHOR_DATE='Tue Nov 1 08:35:12 IST 2016' GIT_COMMITTER_DATE='Tue Nov 1 08:35:12 IST 2016' git commit -m 'commit for Tue Nov 1 08:35:12 IST 2016'
done
echo "########################\n"

echo "Push the remaining commits to the repository"
git push origin master
echo "########################\n"
