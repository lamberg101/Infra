CREATE OR REPLACE PACKAGE GIPKS_ARCHIVE_CUSTOM AS
  /*
  ----------------------------------------------------------------------------------------------------
  **
  ** File Name : GIPKS_ARCHIVE_CUSTOM.SPC
  **
  ** Module : CS
  **
  ** This source is part of the FLEXCUBE Software System
  ** and is copyrighted by Oracle Financial Services Software Limited.
  **
  ** All rights reserved.  No part of this work may be reproduced,
  ** stored in a retrieval system, adopted or transmitted in any form
  ** or by any means, electronic, mechanical, photographic, graphic,
  ** optic recording or otherwise, translated in any language or
  ** computer language, without the prior written permission from
  ** Oracle Financial Services Software Limited.
  **
  ** Oracle Financial Services Software Limited.
  ** 10-11, SDF I, SEEPZ, Andheri (East),
  ** Mumbai - 400 096.
  ** India.
  **** Copyright © 2001- 2011 by Oracle Financial Services Software Limited.
  ----------------------------------------------------------------------------------------------------
  */
  /*
  ----------------------------------------------------------------------------------------------------
        CHANGE HISTORY:
   **   Created By       : Kushab Dhule
   **   Created On       : 23-Aug-2021
   **   Reason           : Purge tables through batch automatically
   
   
   Note: Please maintain new tables to be purged in the "CSTB_PARAM_PURGDTLS_BMI" table before adding code in this package.
      
  ----------------------------------------------------------------------------------------------------
  */
 
                         
  FUNCTION FN_ARCHIVE_WEEKLY  (p_branch      IN VARCHAR2,
                               p_error_code  IN OUT VARCHAR2,
                               p_error_param IN OUT VARCHAR2) RETURN BOOLEAN;
                               
  PROCEDURE pr_ic_entries_purge(p_branch      IN VARCHAR2);
  
  PROCEDURE PR_ARCH_AETB_EOC_PROGRAMS_HIST;
  
  PROCEDURE PR_ARCH_FBTB_TXNLOG_DETLS_HIST;
  
  PROCEDURE PR_ARCH_FBTB_OVD;
  
  PROCEDURE PR_ARCHIVE_SM(P_BRANCH IN VARCHAR2);
  
  PROCEDURE PR_PURGE_BMI_TABLES;

END GIPKS_ARCHIVE_CUSTOM;
/
