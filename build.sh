GAEILGE=${HOME}/gaeilge
REPOS=${HOME}/seal
ROOTDIR=${HOME}/public_html
cat abhar.tsv | egrep -v '^#' | sed "s@{GAEILGE}@${GAEILGE}@g; s@{REPOS}@${REPOS}@g" |
while read x
do
	ACTIVE=`echo "${x}" | cut -f 1`
	SOURCE=`echo "${x}" | cut -f 2`
	TARGET=`echo "${x}" | cut -f 3`
	TITLE=`echo "${x}" | cut -f 4`
	CSS=`echo "${x}" | cut -f 5 | sed 's@\/@\\\/@g'`
	if [ ! -e "${SOURCE}" ]
	then
		echo "Error: source file ${SOURCE} not found..."
	else
		cat nav.html | sed "s/active: false/active: ${ACTIVE}/" | sed "/^<div class=.content.>/r ${SOURCE}" | sed "/^  <title>/s/.*/<title>${TITLE}<\/title>/" > ${ROOTDIR}/${TARGET}
		if [ ! "${CSS}" = "-" ]
		then
			sed -i "/<link.*cadhan.css/s/.*/&\n  <link rel=\"stylesheet\" href=\"\/${CSS}\">/" ${ROOTDIR}/${TARGET}
		fi
	fi
done
cp cadhan.css ${ROOTDIR}/css
cp dunaonghusa.png ${ROOTDIR}/pic
