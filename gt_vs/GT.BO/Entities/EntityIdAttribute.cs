using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.BO.Entities
{
  [Serializable]
  [System.AttributeUsage(AttributeTargets.Property,Inherited=true)]
  public class EntityIdAttribute : Attribute
  {
    
  }
}
