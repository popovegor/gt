namespace GT.Ajax.Controls.ControlBase
{
    public interface IGTAjaxControl
    {
        ControlManager Manager { get; }

        string GetInitScriptCall();

        void DisableScriptControls();
    }
}