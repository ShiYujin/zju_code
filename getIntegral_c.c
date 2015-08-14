#include "mex.h"

bool subExp(double w0, double w1, double w2, double * f, double * g)
{
    double temp0, temp1, temp2;
    temp0 = w0 + w1;
    f[0] = temp0 + w2;
    temp1 = w0 * w0;
    temp2 = w1 * temp0 + temp1;
    f[1] = temp2 + w2 * f[0];
    f[2] = w0 * temp1 + w1 * temp2 + w2 * f[1];
    g[0] = f[1] + w0 * (f[0] + w0);
    g[1] = f[1] + w1 * (f[0] + w1);
    g[2] = f[1] + w2 * (f[0] + w2);

    return 1;
}

void mexFunction(int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[])
{
    double *vertices;
    double *faces;
    //int vertices_num;
    int face_num;
    int v_num;
    int tem;
    double * integral;
    double fx[3];
    double fy[3];
    double fz[3];
    double gx[3];
    double gy[3];
    double gz[3];
    int i;

    double n1x;
    double n1y;
    double n1z;
    double n2x;
    double n2y;
    double n2z;
    double n3x;
    double n3y;
    double n3z;

    double e1x;
    double e1y;
    double e1z;
    double e2x;
    double e2y;
    double e2z;

    double dx;
    double dy;
    double dz;

    if(nrhs < 2) 
    {
        mexPrintf("Paramater not enough!");
        return;
    }
    vertices = mxGetPr(prhs[0]);
    faces = mxGetPr(prhs[1]);
    //vertices_num = prhs[2];
    face_num = mxGetN(prhs[1]);
    v_num = mxGetN(prhs[0]);

    plhs[0] = mxCreateDoubleMatrix(1, 10, mxREAL);
    integral = mxGetPr(plhs[0]);

    for(i = 0; i < face_num; i++)
    {
        tem = faces[3 * i] * 3;
        n1x = vertices[tem - 3];
        n1y = vertices[tem - 2];
        n1z = vertices[tem - 1];
        tem = faces[3 * i + 1] * 3;
        n2x = vertices[tem - 3];
        n2y = vertices[tem - 2];
        n2z = vertices[tem - 1];
        tem = faces[3 * i + 2] * 3;
        n3x = vertices[tem - 3];
        n3y = vertices[tem - 2];
        n3z = vertices[tem - 1];

        e1x = n2x - n1x;
        e1y = n2y - n1y;
        e1z = n2z - n1z;
        e2x = n3x - n1x;
        e2y = n3y - n1y;
        e2z = n3z - n1z;

        dx = e1y * e2z - e1z * e2y;
        dy = e1z * e2x - e1x * e2z;
        dz = e1x * e2y - e1y * e2x;

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

}
