// getIntegral.h : getIntegral DLL ����ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CgetIntegralApp
// �йش���ʵ�ֵ���Ϣ������� getIntegral.cpp
//

class CgetIntegralApp : public CWinApp
{
public:
	CgetIntegralApp();

// ��д
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};
