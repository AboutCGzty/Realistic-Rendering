using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.Rendering.Universal;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class MultiRenderObjects : ScriptableRendererFeature
{
    [System.Serializable]
    public class Settings
    {
        [Range(0, 50)]public int PassLayerNum = 0;
        public RenderPassEvent PassEvent = RenderPassEvent.AfterRenderingSkybox;
        public RenderQueueType RenderQueueType = RenderQueueType.Opaque;
        public LayerMask LayerMask = ~0;
        public string[] PassNames;
    }
    public Settings settings = new Settings();
    MultiRenderObjectsPass m_ScriptablePass;

    public override void Create()
    {
        m_ScriptablePass = new MultiRenderObjectsPass(settings.PassEvent, settings.PassNames, settings.RenderQueueType, settings.LayerMask,settings.PassLayerNum);
    }

    // Here you can inject one or multiple render passes in the renderer.
    // This method is called when setting up the renderer once per-camera.
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        m_ScriptablePass.renderPassEvent = settings.PassEvent;
        renderer.EnqueuePass(m_ScriptablePass);
    }
    public class MultiRenderObjectsPass : ScriptableRenderPass
    {
        string m_ProfilerTag;
        RenderQueueType renderQueueType;
        FilteringSettings m_FilteringSettings;

        List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

        int m_PassLayerNum = 0;

        public MultiRenderObjectsPass(RenderPassEvent renderPassEvent, string[] shaderTags, RenderQueueType renderQueueType, int layerMask,int m_PassLayerNum)
        {
            this.renderPassEvent = renderPassEvent;
            this.renderQueueType = renderQueueType;
            RenderQueueRange renderQueueRange = (renderQueueType == RenderQueueType.Transparent)
                ? RenderQueueRange.transparent
                : RenderQueueRange.opaque;
            m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);

            if (shaderTags != null && shaderTags.Length > 0)
            {
                foreach (var passName in shaderTags)
                    m_ShaderTagIdList.Add(new ShaderTagId(passName));
            }

            this.m_PassLayerNum = m_PassLayerNum;
        }

        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            CommandBuffer cmd = CommandBufferPool.Get("MultiRenderObejcts");

            SortingCriteria sortingCriteria = (renderQueueType == RenderQueueType.Transparent)
                ? SortingCriteria.CommonTransparent
                : renderingData.cameraData.defaultOpaqueSortFlags;

            DrawingSettings drawingSettings;
            if (m_ShaderTagIdList.Count > 0)
                drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
            else return;

            float inter = 1.0f / m_PassLayerNum;
            for (int i = 0; i < m_PassLayerNum; i++)
            {
                cmd.Clear();
                cmd.SetGlobalFloat("_FUR_OFFSET", i * inter);
                context.ExecuteCommandBuffer(cmd);
                context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
            }

            CommandBufferPool.Release(cmd);
        }

        public override void FrameCleanup(CommandBuffer cmd)
        {
        }
    }

}


