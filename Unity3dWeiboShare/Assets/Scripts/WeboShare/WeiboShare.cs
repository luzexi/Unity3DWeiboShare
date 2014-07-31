using UnityEngine;
using System;
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
	private string m_strToken;	//weibo token
	private long m_lTokenTime;	//weibo token time
	private string m_strMsg;	//txt msg;

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

	public void clear()
	{
		this.m_lTokenTime = 0;
		this.m_strToken = "";
	}

	[DllImport("__Internal")]
	private static extern void _weiboInit(string gameObject);
	public void Init()
	{
		this.m_strToken = PlayerPrefs.GetString("weibo_token");
		string strTime = PlayerPrefs.GetString("weibo_token_time");
		if(strTime.Length > 0 )
			this.m_lTokenTime = long.Parse(strTime);
		else
			this.m_lTokenTime = 0;
		_weiboInit("WeiboShare");
	}

	[DllImport("__Internal")]
	private static extern void _weiboAuthorize();
	public void Authorize()
	{
		_weiboAuthorize();
	}

	[DllImport("__Internal")]
	private static extern void _weiboShare(string token , string msg);
	public void Share( string msg )
	{
		Debug.Log("u3d Share");
		this.m_strMsg = msg;
		if( DateTime.Now.Ticks - this.m_lTokenTime > 24L*3600L*1000L*10000L )
		{
			Authorize();
		}
		else
			_weiboShare(this.m_strToken , this.m_strMsg);
	}

	/// <summary>
	/// Raises the request event.
	/// </summary>
	/// <param name="res">Res.</param>
	public void OnAuthorize( string token )
	{
		this.m_strToken = token;
		this.m_lTokenTime = DateTime.Now.Ticks;
		PlayerPrefs.SetString("weibo_token",this.m_strToken);
		PlayerPrefs.SetString("weibo_token_time" , ""+this.m_lTokenTime);
		Debug.Log("u3d OnAuthorize");
		Share(this.m_strMsg);
	}

	/// <summary>
	/// Raises the share event.
	/// </summary>
	/// <param name="res">Res.</param>
	public void OnShare(string res)
	{
		Debug.Log("onshare " + res);
	}
}
