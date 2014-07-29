using UnityEngine;
using System.Runtime.InteropServices;
using System.Collections;


//	WeiboShare.cs
//	Author: Lu Zexi
//	2014-07-28



/// <summary>
/// Weibo share.
/// </summary>
public class WeiboShare : MonoBehaviour
{
	private static WeiboShare s_cInstance;
	public static WeiboShare sInstance
	{
		get
		{
			if(s_cInstance == null )
			{
				GameObject obj = new GameObject("WeiboShare");
				s_cInstance = obj.AddComponent<WeiboShare>();
			}
			return s_cInstance;
		}
	}

	void OnDestroy()
	{
		s_cInstance = null;
	}

	[DllImport("__Internal")]
	private static extern void _weiboInit(string gameObject);
	public void Init()
	{
		_weiboInit("WeiboShare");
	}

	[DllImport("__Internal")]
	private static extern void _weiboShare();
	public void Share()
	{
		_weiboShare();
	}

	/// <summary>
	/// Raises the request event.
	/// </summary>
	/// <param name="res">Res.</param>
	public void OnRequest( string res)
	{
		Debug.Log(res);
	}
}
