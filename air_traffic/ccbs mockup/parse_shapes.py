import sys
import os.path

f = open(sys.argv[1])
lines = f.readlines()

cmd = sys.argv[2]
pfx = sys.argv[3]

shapes = []

i = 0
while i < len(lines):
	line = lines[i].strip()
	if(line.startswith('int[]')):
		lin1 = line
		lin2 = lines[i+1].strip()
		lin1s = lin1.split()
		lin2s = lin2.split()
		name = os.path.commonprefix([lin1s[1], lin2s[1]]).replace('_', ' ')
		name = name.strip()
		pts = []
		for j in range(3, len(lin1s)):
			str1 = lin1s[j]
			str2 = lin2s[j]
			xc = str1.replace('{','').replace(',','').replace('}','').replace(';','')
			yc = str2.replace('{','').replace(',','').replace('}','').replace(';','')
			pts.append((xc,yc))
		shapes.append((name, pts))
		i = i + 1
	i = i + 1

for (name, pts) in shapes:
	flatPts = ''
	for (xc, yc) in pts:
		flatPts = flatPts + str(xc) + ',' + str(yc) + ' ; '
	print '%s : %s ; %s %s ; %s' % (cmd, name, pfx, name, flatPts)

