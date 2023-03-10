package gral;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import rhgral.bizlayer.RhGralSessAdmIngresos;
import ar.com.itrsa.sam.IContext;
import ar.com.itrsa.sam.IServiceAccessManager;

public abstract class SAMConnection {
	
	private static final Log log = LogFactory.getLog(RhGralSessAdmIngresos.class);
	
	protected static IServiceAccessManager 	sam = null; 
	protected static  IContext				samContext = null;

	
	public SAMConnection(){		
		
	}


	public static IServiceAccessManager getSam() {
		return sam;
	}


	public static void setSam(IServiceAccessManager sam) {
		SAMConnection.sam = sam;
	}


	public static IContext getSamContext() {
		return samContext;
	}


	public static void setSamContext(IContext samContext) {
		SAMConnection.samContext = samContext;
	}
}
