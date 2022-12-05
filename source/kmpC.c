
int strlen(char *s_array)
{
    int s_len = 0;
    while(1){
        if (s_array[s_len] == 0) break;
        s_len = s_len + 1;
    } 
    return s_len;
}

int match(char *m_s, char *m_t, int m_pos, int *m_next)
{
	int m_i = m_pos;
	int m_j = 0;
    int m_slen = strlen(m_s);
    int m_tlen = strlen(m_t);
	while ((m_i < m_slen) && (m_j < m_tlen))
	{
		if ((m_j == -1) || (m_s[m_i] == m_t[m_j]))
		{
			m_i = m_i + 1;
			m_j = m_j + 1;
		}
		else
		{
			m_j = m_next[m_j];
		}
	}

	if (m_tlen == m_j)
	{
		return m_i - m_tlen;
	}
    return -1;
}


int get_next(char *g_t, int *g_next)
{
	int g_k = -1;
	int g_j = 0;
	g_next[0] = -1;
    int g_tlen = strlen(g_t);
    printf("g_tlen = %d\n\n", g_tlen);
	while (g_j < g_tlen)
	{
		if ((g_k == -1) || (g_t[g_j] == g_t[g_k]))
		{
			g_k = g_k + 1;
			g_j = g_j + 1;
			g_next[g_j] = g_k;
			printf("g_next[%d] = %d\n", g_j, g_next[g_j]);
            printf("g_next[%d] = %d\n", g_k, g_next[g_k]);
		}
		else
		{
			g_k = g_next[g_k];
		}
	}
    return 0;
}


int print_next(int *p_next, int p_n)
{
    int p_i = 0;
	while (p_i < p_n)
	{
		printf("p_next[%d] = %d\n", p_i, p_next[p_i]);
        p_i = p_i + 1;
	}
    return 0;
}

int main()
{
	char s[100] = "ababcabcacbab";
	char t[100] = "abcac";
    printf("t:%s\n",  t);
    char *s_ptr = s;
    char *t_ptr = t;

	printf("\nKMP test:\n");
	int next[32] = "\0";
	get_next(t_ptr, next);

    int tlen = strlen(t_ptr);
	print_next(next, tlen);

	int pos = 0;
	int index = match(s_ptr, t_ptr, pos, next);
	printf("index = %d\n", index);
	return 0;
}
