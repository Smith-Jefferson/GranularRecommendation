%��ʽ������
dataFormat();
%�û�����
%%1.�����û�ƫ�þ���
matrix=userPrefrence(data);
%%2.�ֲھ���
SIM  = SIMMatrix( matrix );%�û����ƶ�
cluster = RoughCluster( SIM );
%%3.��Ļ���ƫ�ã�
clusterGene=produceClusterGene(cluster,matrix);
%�������ȡ��ѡ����
%%��Ҫ�Ƽ����û�
users=matrix(:,1);
userid=users(1);
candidateSet=getCandidateSet(userid,matrix,cluster,clusterGene);
recommendItems=recommendation(userid,matrix,candidateSet,10,true);




            
            
            
        
    
