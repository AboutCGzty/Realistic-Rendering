using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class PointCloud : MonoBehaviour
{
    public Vector3 Size = Vector3.one;
    public float Delta = 2f;
    LightProbeGroup probeGroup = null;
    void Start()
    {
        
    }
     public void GenProbe()
    {
        if (probeGroup == null)
        {
            probeGroup = gameObject.AddComponent<LightProbeGroup>();
        }

        //probeGroup.probePositions = new Vector3[] { Vector3.up, Vector3.down, Vector3.right, Vector3.left };

        List<Vector3> probes = new List<Vector3>();

        Vector3 center = GetComponent<BoxCollider>().center;//0
        Vector3 size = GetComponent<BoxCollider>().size;//10


        float x_begin = center.x - size.x / 2;
        float x_end = center.x + size.x / 2;

        float y_begin = center.y - size.y / 2;
        float y_end = center.y + size.y / 2;

        float z_begin = center.z - size.z / 2;
        float z_end = center.z + size.z / 2;

        for (float x = x_begin; x <= x_end; x+= Delta)
        {
            for (float y = y_begin; y <= y_end; y+= Delta)
            {
                for (float z = z_begin; z <= z_end; z+= Delta)
                {
                    probes.Add(new Vector3(x,y,z) + transform.position);
                }
            }
        }
        Debug.Log(probes.Count);
        probeGroup.probePositions = probes.ToArray();

        foreach (var item in probes)
        {
            print(item);
        }

    }


    // Update is called once per frame
    void Update()
    {
        
    }
}
