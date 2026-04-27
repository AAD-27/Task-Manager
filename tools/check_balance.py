import sys
path = r"d:\Ameya\BITS\Cross API\Cross Platform API Dev\lib\screens\task_list_screen.dart"
text = open(path, 'r', encoding='utf-8').read()
pairs = {'(':')','{':'}','[':']'}
openings = set(pairs.keys())
closings = set(pairs.values())
stack = []
for idx, ch in enumerate(text):
    if ch in openings:
        stack.append((ch, idx))
    elif ch in closings:
        if not stack:
            line = text.count('\n',0,idx)+1
            col = idx - text.rfind('\n',0,idx)
            print(f"Unmatched closing {ch} at line {line} col {col}")
            sys.exit(0)
        last, last_idx = stack[-1]
        if pairs[last] == ch:
            stack.pop()
        else:
            li = text.count('\n',0,last_idx)+1
            coll = last_idx - text.rfind('\n',0,last_idx)
            line = text.count('\n',0,idx)+1
            col = idx - text.rfind('\n',0,idx)
            print(f"Mismatched: {last} opened at line {li} col {coll} but closed by {ch} at line {line} col {col}")
            sys.exit(0)

if stack:
    print('Unclosed openings:')
    for ch, last_idx in stack[-20:]:
        li = text.count('\n',0,last_idx)+1
        col = last_idx - text.rfind('\n',0,last_idx)
        print(f"{ch} at line {li} col {col}")
else:
    print('All balanced')
