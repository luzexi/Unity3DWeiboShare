using UnityEngine;
using System.Collections;

public class WeiboTest : MonoBehaviour {

	// Use this for initialization
	void Start ()
	{
		WeiboShare.sInstance.Init();
	}
	
	// Update is called once per frame
	void Update () {
	
	}


	void OnGUI()
	{
		if(GUI.Button(new Rect(0,0,100,100) , "share"))
		{
			WeiboShare.sInstance.Share("SDK test in the weibo");
		}

		if(GUI.Button(new Rect(0,110,100,100),"Authorize"))
		{
			WeiboShare.sInstance.Authorize();
		}

		if(GUI.Button(new Rect(0,220,100,100),"clear"))
		{
			WeiboShare.sInstance.clear();
		}
	}
}
