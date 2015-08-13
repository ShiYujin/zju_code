#ifndef OBJLOADER_H
#define OBJLOADER_H
#include<vector>
using namespace std;
bool loadOBJ(
	const char * path, 
	vector<vector<float>> & out_vertices, 
	vector<vector<int>> & out_faces
);

#endif