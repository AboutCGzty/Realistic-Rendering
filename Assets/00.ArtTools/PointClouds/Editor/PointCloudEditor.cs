using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(PointCloud))]
public class PointCloudEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();
        PointCloud pc = target as PointCloud;

        //Handles.CubeHandleCap(0, pc.transform.position, pc.transform.rotation, pc.Size.x,EventType.MouseDrag);
        //Handles.DrawWireCube(pc.transform.position,pc.Size);

        if (GUILayout.Button("GenProbe"))
        {
            pc.GenProbe();
        }
    }
}
