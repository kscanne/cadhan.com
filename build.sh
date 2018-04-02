GAEILGE=${HOME}/gaeilge
REPOS=${HOME}/seal
ROOTDIR=${HOME}/public_html
cat abhar.tsv | egrep -v '^#' | sed "s@{GAEILGE}@${GAEILGE}@g; s@{REPOS}@${REPOS}@g" |
while read x
do
	TEANGA=`echo "${x}" | cut -f 1`
	ACTIVE=`echo "${x}" | cut -f 2`
	SOURCE=`echo "${x}" | cut -f 3`
	TARGET=`echo "${x}" | cut -f 4`
	TITLE=`echo "${x}" | cut -f 5`
	CSS=`echo "${x}" | cut -f 6 | sed 's@\/@\\\/@g'`
	if [ "${TEANGA}" = "en" ]
	then
		NAV="nav-en.html"
		AISTRIUCHAN=`echo "${TARGET}" | sed 's/-en\.html$/.html/'`
	else
		NAV="nav.html"
		AISTRIUCHAN=`echo "${TARGET}" | sed 's/\.html$/-en.html/'`
	fi
	if [ ! -e "${SOURCE}" ]
	then
		echo "Error: source file ${SOURCE} not found..."
	else
		cat "${NAV}" | sed "s@AISTRIUCHAN@/${AISTRIUCHAN}@" | sed "s/active: false/active: ${ACTIVE}/" | sed "/^<div class=.content.>/r ${SOURCE}" | sed "/^  <title>/s/.*/<title>${TITLE}<\/title>/" > ${ROOTDIR}/${TARGET}
		if [ ! "${CSS}" = "-" ]
		then
			sed -i "/<link.*cadhan.css/s/.*/&\n  <link rel=\"stylesheet\" href=\"\/${CSS}\">/" ${ROOTDIR}/${TARGET}
		fi
	fi
done
cp cadhan.css ${ROOTDIR}/css
cp dunaonghusa.png ${ROOTDIR}/pic
cp favicon.png ${ROOTDIR}/pic
cp by-sa-80x15.png ${ROOTDIR}/pic
