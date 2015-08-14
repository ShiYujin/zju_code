#include <vector>
#include <stdio.h>
#include <string>
#include <cstring>
#include <vector>
//#include <glm/glm.hpp>

#include "objloader.h"

using namespace std;

bool loadOBJ(const char * path, vector<vector<float>> & out_vertices, vector<vector<int>> & out_faces)
{
	printf("Loading OBJ file %s...\n", path);

	FILE * file = fopen(path, "r");
	if( file == NULL ){
		printf("Impossible to open the file ! Are you in the right path ? See Tutorial 1 for details\n");
		getchar();
		return false;
	}

	while( 1 ){
		char lineHeader[128];
		// read the first word of the line
		int res = fscanf(file, "%s", lineHeader);
		if (res == EOF)
			break; // EOF = End Of File. Quit the loop.

		// else : parse lineHeader
		
		if ( strcmp( lineHeader, "v" ) == 0 ){
			float x = 0, y = 0, z = 0;
			fscanf(file, "%f %f %f\n", &x, &y, &z );
			vector<float>xyz;
			xyz.push_back(x);
			xyz.push_back(y);
			xyz.push_back(z);
			out_vertices.push_back(xyz);
		}else if ( strcmp( lineHeader, "vt" ) == 0 ){
			;
		}else if ( strcmp( lineHeader, "vn" ) == 0 ){
			;
		}else if ( strcmp( lineHeader, "f" ) == 0 ){
			int v1 = 0, v2 = 0, v3 = 0;
			char s[15];
			fscanf(file, "%d%s %d%s %d%s\n", &v1, &s, &v2, &s, &v3, &s);
			vector<int>face;
			face.push_back(v1);
			face.push_back(v2);
			face.push_back(v3);
			out_faces.push_back(face);

		}else{
			// Probably a comment, eat up the rest of the line
			;
		}

	}

	return true;
}
