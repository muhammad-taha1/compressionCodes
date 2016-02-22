
probSet = [0.5, 0.3, 0.2];
symbolSet = [0, 1, 2];
mapObj = containers.Map(probSet, symbolSet);
min_prob = min(probSet);

str = '1';
tree = containers.Map(min_prob, str);

keys = keys(tree);
val = values(tree);

b = probSet(probSet ~= min_prob);
min_prob = min(b);
str = [str, '0'];


add(tree, min_prob, str);
b = probSet(probSet ~= min_prob);





