using UnityEngine;
using System;
using System.IO;
using System.Collections;

public class WeiboTest : MonoBehaviour {

	// Use this for initialization
	void Start ()
	{
		Texture2D tex = Resources.Load("share_img") as Texture2D;
		byte[] data = tex.EncodeToPNG();
		string imgPath = Application.persistentDataPath + "/" + "share_img.png";
		Debug.Log(" ===== persistentDataPath " + imgPath);
		File.WriteAllBytes(imgPath , data);
		WeiboShare.sInstance.Init();
	}
	
	// Update is called once per frame
	void Update () {
	
	}


	void OnGUI()
	{
		if(GUI.Button(new Rect(0,0,100,100) , "share img"))
		{
			//string imgPath = System.IO.Path.Combine(Application.streamingAssetsPath, "share_img.png");
			string imgPath = Application.persistentDataPath + "/" + "share_img.png";
			WeiboShare.sInstance.Share("SDK test to share the img.",imgPath);
		}

		if(GUI.Button(new Rect(0,110,100,100) , "share text"))
		{
			WeiboShare.sInstance.Share("SDk test to share the text.");
		}


		if(GUI.Button(new Rect(0,220,100,100),"clear"))
		{
			WeiboShare.sInstance.clear();
		}
	}
}
