#include "objloader.h"
#include <vector>
#include <Windows.h>

using namespace std;

bool getIntegral(vector<vector<float>>vertices, vector<vector<int>>faces, float* integral);

int main ()
{
	char * path = "E:/Project/zju_code/triangleMesh/3spheres_stand_v2.obj"; 
	vector<vector<float>> out_vertices;
	vector<vector<int>> out_faces;
	loadOBJ(path,out_vertices, out_faces);

	for(int i = 0; i < out_vertices.size(); i++)
	{
		printf("%f\t%f\t%f\n",out_vertices[i][0],out_vertices[i][1],out_vertices[i][2]);
	}
	for(int i = 0; i < out_faces.size(); i++)
	{
		printf("%d\t%d\t%d\n",out_faces[i][0],out_faces[i][1],out_faces[i][2]);
	}

	float integral [10] = {0};
	double start = GetTickCount();
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	getIntegral(out_vertices,out_faces,integral);
	double end = GetTickCount();
	printf("mass:\t%f\n",integral[0]);
	printf("cm:  \t%f\t%f\t%f\n",integral[1],integral[2],integral[3]);
	printf("i :  \t%f\t%f\t%f\n",integral[4],integral[5],integral[6]);
	printf("     \t%f\t%f\t%f\n",integral[7],integral[8],integral[9]);
	printf("\n\ntime:\t%f", end - start);
}

bool subExp(float w0, float w1, float w2, float * f, float * g)
{
	float temp0 = w0 + w1;
	f[0] = temp0 + w2;
	float temp1 = w0 * w0;
	float temp2 = w1 * temp0 + temp1;
	f[1] = temp2 + w2 * f[0];
	f[2] = w0 * temp1 + w1 * temp2 + w2 * f[1];
	g[0] = f[1] + w0 * (f[0] + w0);
	g[1] = f[1] + w1 * (f[0] + w1);
	g[2] = f[1] + w2 * (f[0] + w2);

	return 1;
}

bool getIntegral(vector<vector<float>>vertices, vector<vector<int>>faces, float* integral)
{
	float fx[3];
	float fy[3];
	float fz[3];
	float gx[3];
	float gy[3];
	float gz[3];

	for(int i = 0; i < faces.size(); i++)
	{
		float n1x = vertices[faces[i][0] - 1][0];
		float n1y = vertices[faces[i][0] - 1][1];
		float n1z = vertices[faces[i][0] - 1][2];
		float n2x = vertices[faces[i][1] - 1][0];
		float n2y = vertices[faces[i][1] - 1][1];
		float n2z = vertices[faces[i][1] - 1][2];
		float n3x = vertices[faces[i][2] - 1][0];
		float n3y = vertices[faces[i][2] - 1][1];
		float n3z = vertices[faces[i][2] - 1][2];

		float e1x = n2x - n1x;
		float e1y = n2y - n1y;
		float e1z = n2z - n1z;
		float e2x = n3x - n1x;
		float e2y = n3y - n1y;
		float e2z = n3z - n1z;

		float dx = e1y * e2z - e1z * e2y;
		float dy = e1z * e2x - e1x * e2z;
		float dz = e1x * e2y - e1y * e2x;

		subExp(n1x, n2x, n3x, fx, gx);
		subExp(n1y, n2y, n3y, fy, gy);
		subExp(n1z, n2z, n3z, fz, gz);

		integral[0] += dx * fx[0];
		integral[1] += dx * fx[1];
		integral[2] += dy * fy[1];
		integral[3] += dz * fz[1];
		integral[4] += dx * fx[2];
		integral[5] += dy * fy[2];
		integral[6] += dz * fz[2];
		integral[7] += dx * (n1y * gx[0] + n2y * gx[1] + n3y * gx[2]);
		integral[8] += dy * (n1z * gy[0] + n2z * gy[1] + n3z * gy[2]);
		integral[9] += dz * (n1x * gz[0] + n2x * gz[1] + n3x * gz[2]);
	}
	integral[0] /= 6;
	integral[1] /= 24;
	integral[2] /= 24;
	integral[3] /= 24;
	integral[4] /= 60;
	integral[5] /= 60;
	integral[6] /= 60;
	integral[7] /= 120;
	integral[8] /= 120;
	integral[9] /= 120;

	return 1;
}